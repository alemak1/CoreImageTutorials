//
//  ViewController.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import UIKit
import CoreImage
import MapKit

class ViewController: UIViewController {

    var beforeFilterImageView = UIImageView()
    var afterFilterImageView = UIImageView()
    
    var mapView = MKMapView()
    let mapViewTapGR = UITapGestureRecognizer(target: self, action: #selector(ViewController.showMapViewModally))
    
    var anotherMapView = MKMapView()

    var mapViewLabel = UILabel()
    var anotherMapViewLabel = UILabel()
    var locationOptionLabel = UILabel()
    var anotherLocationOptionLabel = UILabel()
    
    var mapsHaveLoaded: Bool = false
    
    //MARK: ********* MapView LayoutConstraints
    
    var mapViewCenterYConstraint: NSLayoutConstraint!
    var mapViewHorizontalConstraint: NSLayoutConstraint!
    var mapViewWidthConstraint: NSLayoutConstraint!
    var mapViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: ******** ANOTHER MAP VIEW LAYOUT CONSTRAINTS
    
     var anotherMapViewCenterYConstraint: NSLayoutConstraint!
     var anotherMapViewHorizontalConstraint: NSLayoutConstraint!
     var anotherMapViewHeightConstraint: NSLayoutConstraint!
     var anotherMapViewWidthConstraint: NSLayoutConstraint!
    
    
    
    let filterGenerator: CIFilterGenerator = CIFilterGenerator.sharedInstance
    
    override func viewWillLayoutSubviews() {
     
   
        view.addSubview(mapView)
        view.addSubview(anotherMapView)
        view.addSubview(locationOptionLabel)
        view.addSubview(anotherLocationOptionLabel)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        anotherMapView.translatesAutoresizingMaskIntoConstraints = false
        locationOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        anotherLocationOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationOptionLabel.textColor = UIColor.cyan
        locationOptionLabel.adjustsFontSizeToFitWidth = true
        
        anotherLocationOptionLabel.textColor = UIColor.cyan
        anotherLocationOptionLabel.adjustsFontSizeToFitWidth = true
        
        configureDefaultMapViewConstraints()
        configureDefaultLabelConstraints()
        configureLocationOptionLabel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register notification for UpateMapNotification
        let notificationName = Notification.Name(rawValue: "updateMapViewNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateMapData(notification:)), name: notificationName, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        anotherMapView.delegate = self
        
        
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        
        //Nana BTS Station
        let latCoord1 = 13.740505
        let longCoord1 = 100.555421
        let locationCoordinate1 = CLLocationCoordinate2D(latitude: latCoord1, longitude: longCoord1)
        
        
        //Asok BTS Station
        let latCoord2 = 13.737009
        let longCoord2 = 100.560388
        let locationCoordinate2 = CLLocationCoordinate2D(latitude: latCoord2, longitude: longCoord2)
        
        
       
        mapView.region = MKCoordinateRegion(center: locationCoordinate1, span: mapSpan)        
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        
        anotherMapView.region = MKCoordinateRegion(center: locationCoordinate2, span: mapSpan)
        anotherMapView.isScrollEnabled = false
        anotherMapView.isZoomEnabled = false
        
        mapViewLabel.text = "Starting Location"
        mapViewLabel.textColor = UIColor.cyan
        
        anotherMapViewLabel.text = "Destination"
        anotherMapViewLabel.textColor = UIColor.cyan
        
       
        mapView.addGestureRecognizer(self.mapViewTapGR)
        
        
        
        let anotherMapViewTapGR = UITapGestureRecognizer(target: self, action: #selector(ViewController.showMapViewModally))
        anotherMapView.addGestureRecognizer(anotherMapViewTapGR)
        
        
        let currentLocationTapGR = UITapGestureRecognizer(target: self, action: #selector(ViewController.configureUserLocationForStartingPoint(sender:)))
        locationOptionLabel.text = "Use Current Location"
        locationOptionLabel.addGestureRecognizer(currentLocationTapGR)
        
        anotherLocationOptionLabel.textColor = UIColor.cyan
        anotherLocationOptionLabel.text = "Use Current Location"
        
        
        addPreConfiguredAnnotations()
        
        
    }
    
    func configureUserLocationForStartingPoint(sender: UITapGestureRecognizer){
        
        mapView.removeGestureRecognizer(self.mapViewTapGR)
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        mapView.centerCoordinate = anotherMapView.centerCoordinate//mapView.userLocation.coordinate
        mapViewLabel.text = "Another Starting Location"
    }
    
    
    func showMapViewModally(sender: UITapGestureRecognizer){
        
        if let mapView = sender.view as? MKMapView, mapView == self.mapView{
            let modalMapVC = ModalMapViewController(mapView: mapView, mapType: .StartingPoint)
            self.navigationController?.pushViewController(modalMapVC, animated: true)
            
        }
        
        
        if let mapView = sender.view as? MKMapView, mapView == self.anotherMapView{
            let modalMapVC = ModalMapViewController(mapView: mapView, mapType: .Destination)
            self.navigationController?.pushViewController(modalMapVC, animated: true)
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** Centers a subview in the center of the rootView by aligning the added subview's centerX and centerY with rootView's centerX and centerY
     
     **/
    
     func configureCenteringConstraints(forSubView subView: UIView){
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subView)
        
        let imageViewWidth = view.bounds.width*0.90
        let imageViewHeight = view.bounds.height*0.90
        
        NSLayoutConstraint.activate([
            subView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            subView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
    }
    
    
    func configureDefaultMapViewConstraints(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        anotherMapView.translatesAutoresizingMaskIntoConstraints = false
        
        // *********** Constraint Configuration Constants
        let standardOffset = CGFloat(10)

        var horizontalPadding = CGFloat(10.00)
        var viewWidth = (view.bounds.width*0.50) - horizontalPadding
        
        var verticalPadding = CGFloat(10.00)
        var viewHeight = (view.bounds.height*0.50) - verticalPadding
        
        
        var quarterWidth = view.bounds.width*0.25
        
        //Set the default constraints for mapView and anotherMapView
        
        self.mapViewWidthConstraint = mapView.widthAnchor.constraint(equalToConstant: viewWidth)
        self.mapViewHeightConstraint = mapView.heightAnchor.constraint(equalToConstant: viewHeight)
        
        self.anotherMapViewWidthConstraint = anotherMapView.widthAnchor.constraint(equalToConstant: viewWidth)
        self.anotherMapViewHeightConstraint = anotherMapView.heightAnchor.constraint(equalToConstant: viewHeight)
        
        self.mapViewCenterYConstraint = mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        self.anotherMapViewCenterYConstraint = anotherMapView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        
        self.mapViewHorizontalConstraint = mapView.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: quarterWidth)
        
        
        self.anotherMapViewHorizontalConstraint = anotherMapView.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -quarterWidth)
        
        
        //Activate the default constraints
        
        NSLayoutConstraint.activate([
            self.mapViewWidthConstraint,
            self.mapViewHeightConstraint,
            self.mapViewCenterYConstraint,
            self.mapViewHorizontalConstraint,
            self.anotherMapViewWidthConstraint,
            self.anotherMapViewHeightConstraint,
            self.anotherMapViewCenterYConstraint,
            self.anotherMapViewHorizontalConstraint
        ])
        

    }
    
    
    func configureDefaultLabelConstraints(){
        

        
        view.addSubview(mapViewLabel)
        view.addSubview(anotherMapViewLabel)
        
        mapViewLabel.translatesAutoresizingMaskIntoConstraints = false
        anotherMapViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapViewLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0.0),
            mapViewLabel.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -20.0),
            anotherMapViewLabel.centerXAnchor.constraint(equalTo: anotherMapView.centerXAnchor, constant: 0.0),
            anotherMapViewLabel.bottomAnchor.constraint(equalTo: anotherMapView.topAnchor, constant: -20.0)
            ])
        
    }
    
    func configureLocationOptionLabel(){
        
        
        
        NSLayoutConstraint.activate([
            locationOptionLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0.00),
            locationOptionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10.0),
            locationOptionLabel.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.90)
            ])
        
        NSLayoutConstraint.activate([
            anotherLocationOptionLabel.centerXAnchor.constraint(equalTo: anotherMapView.centerXAnchor, constant: 0.00),
            anotherLocationOptionLabel.topAnchor.constraint(equalTo: anotherMapView.bottomAnchor, constant: 10.00),
            anotherLocationOptionLabel.widthAnchor.constraint(equalTo: anotherMapView.widthAnchor, multiplier: 0.90)
            ])
        
        
    }

    
    private func configureSideBySideConstraints(forFirstSubview firstSubview: UIView, andSecondSubView secondSubView: UIView){
        
        firstSubview.translatesAutoresizingMaskIntoConstraints = false
        secondSubView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(firstSubview)
        view.addSubview(secondSubView)
        
        let horizontalPadding = CGFloat(10.00)
        let verticalPadding = CGFloat(10.00)
        let viewWidth = (view.bounds.width*0.50) - horizontalPadding
        let viewHeight = (view.bounds.height*0.50) - verticalPadding
        let standardOffset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            firstSubview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondSubView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstSubview.widthAnchor.constraint(equalToConstant: viewWidth),
            secondSubView.widthAnchor.constraint(equalToConstant: viewWidth),
            firstSubview.heightAnchor.constraint(equalToConstant: viewHeight),
            secondSubView.heightAnchor.constraint(equalToConstant: viewHeight),
            firstSubview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: standardOffset),
            secondSubView.leftAnchor.constraint(equalTo: firstSubview.rightAnchor, constant: standardOffset)
            ])
        
    }
    
    
    func updateMapData(notification: NSNotification){
        
        if let updatedMapInfo = notification.userInfo{
            let updatedLongitude = updatedMapInfo["UpdatedLongitude"] as! Double
            let updatedLatitude = updatedMapInfo["UpdatedLatitude"] as! Double
            let updatedLatitudeDelta = updatedMapInfo["UpdatedLatitudeDelta"] as! Double
            let updatedLongitudeDelta = updatedMapInfo["UpdatedLongitudeDelta"] as! Double
            let updatedMapType = updatedMapInfo["UpdatedMapType"] as! Int
            
            let updatedLocation = CLLocationCoordinate2D(latitude: updatedLatitude, longitude: updatedLongitude)
            let updatedSpan = MKCoordinateSpan(latitudeDelta: updatedLatitudeDelta, longitudeDelta: updatedLongitudeDelta)
            
            if updatedMapType == 1{
                anotherMapView.region = MKCoordinateRegion(center: updatedLocation, span: updatedSpan)
            }
            
            if updatedMapType == 2{
                mapView.region = MKCoordinateRegion(center: updatedLocation, span: updatedSpan)
            }
        }
    }
    
    
    func removeMapViewConstraints(){
        
        mapView.removeConstraints([
            self.mapViewWidthConstraint,
            self.mapViewHeightConstraint,
            self.mapViewCenterYConstraint,
            self.mapViewHorizontalConstraint
            ])
    }

    func removeAnotherMapViewConstraints(){
        anotherMapView.removeConstraints([
            self.anotherMapViewCenterYConstraint,
            self.anotherMapViewHeightConstraint,
            self.anotherMapViewWidthConstraint,
            self.anotherMapViewHorizontalConstraint
            ])
        
    }

    
    
    func addPreConfiguredAnnotations(){
        
        var sampleAnnotations = [MKAnnotation]()
        
        let nanaLat = 13.740505
        let nanaLong = 100.555421
        let nanaLocation = CLLocationCoordinate2D(latitude: nanaLat, longitude: nanaLong)
        let nanaStation = TouristSpot(coordinate: nanaLocation, title: "Nana BTS Station", subtitle: "A BTS stop on the Bangkok SkyTrain", siteDescription: "A stop on the Bangkok SkyTrain")
        sampleAnnotations.append(nanaStation)
        
        let lat1 = 13.737718
        let long1 = 100.560350
        let location1 = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        let touristSpot1 = TouristSpot(coordinate: location1, title: "Terminal 21", subtitle: "Shopping Center", siteDescription: "A great place to go shopping")
        
        sampleAnnotations.append(touristSpot1)
        
        let lat2 = 13.737009
        let long2 = 100.560388
        let location2 = CLLocationCoordinate2D(latitude: lat2, longitude: long2)
        let touristSpot2 = TouristSpot(coordinate: location2, title: "Asok Station", subtitle: "BTS(SkyTrain) Station", siteDescription: "A stop on Bangkok's BTS SkyTrain")
        sampleAnnotations.append(touristSpot2)
        
        let lat3 = 13.737561
        let long3 = 100.559165
        let location3 = CLLocationCoordinate2D(latitude: lat3, longitude: long3)
        let touristSpot3 = TouristSpot(coordinate: location3, title: "Sheraton Hotel", subtitle: "5-Star Hotel", siteDescription: "A 5-star hotel with beautiful accomdations and also connected directly to the subway station")
        sampleAnnotations.append(touristSpot3)
        
        let lat4 = 13.737764
        let long4 = 100.558789
        let location4 = CLLocationCoordinate2D(latitude: lat4, longitude: long4)
        let touristSpot4 = TouristSpot(coordinate: location4, title: "Times Square Shopping Mall", subtitle: "A great place to go shopping", siteDescription: "A high-end shopping mall with a food court in the basement")
        sampleAnnotations.append(touristSpot4)
        
        
       mapView.addAnnotations(sampleAnnotations)
        anotherMapView.addAnnotations(sampleAnnotations)
    
    }

  
}

extension ViewController: MKMapViewDelegate{
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if(mapView == self.mapView){
            mapViewLabel.text = "Starting Location"
            mapViewLabel.textColor = UIColor.cyan
        }
        
        if(mapView == self.anotherMapView){
            anotherMapViewLabel.text = "Destination"
            anotherMapViewLabel.textColor = UIColor.cyan
        }
        
        mapsHaveLoaded = true
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        //Not yet implemented
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        
        if(mapView == self.mapView){
            mapViewLabel.text = "Getting starting location..."
            mapViewLabel.textColor = UIColor.cyan
        }
        
        if(mapView == self.anotherMapView){
            anotherMapViewLabel.text = "Getting destination..."
            anotherMapViewLabel.textColor = UIColor.cyan
        }
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        //Not yet implemented
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        //Not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        //Not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //Not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        //Not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        //Not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //Not yet implemented
    }
    
    /** Tells the delegate that the region displayed by the MapView is about to change **/
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
      

        
        mapViewLabel.text = "Starting Location (Updated)"
        mapViewLabel.textColor = UIColor.cyan
        
        anotherMapViewLabel.text = "Destination (Updated)"
        anotherMapViewLabel.textColor = UIColor.cyan
        
        
       /**
        view.layoutIfNeeded()
        
        
        let halfScreenWidth = view.bounds.width*0.50
        
        if(mapView == self.mapView){
            UIView.animate(withDuration: 1.0, animations: {
                
                self.mapViewHorizontalConstraint.constant = halfScreenWidth
                self.anotherMapViewHorizontalConstraint.constant = halfScreenWidth
                
                self.view.layoutIfNeeded()
            })
            
        }
        
        
        if(mapView == self.anotherMapView){
            UIView.animate(withDuration: 1.0, animations: {
                
                self.mapViewHorizontalConstraint.constant = -halfScreenWidth
                self.anotherMapViewHorizontalConstraint.constant = -halfScreenWidth
                
                self.view.layoutIfNeeded()
            })
            
        }
        
        **/

        
    }
    
    /** Tells the delegate that the region displayed by the MapView already did change **/
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if(mapView == self.mapView){
            mapViewLabel.text = "Altering starting location..."
            mapViewLabel.textColor = UIColor.cyan
        }
        
        if(mapView == self.anotherMapView){
            anotherMapViewLabel.text = "Altering destination..."
            anotherMapViewLabel.textColor = UIColor.cyan
        }
        
        
        
    }
    
    

    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        //not yet implemented
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        //not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //not yet implemented
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        // not yet implemented
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        //not yet implemented
    }
    
    /**
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //not yet implemented
    }
     **/
}

/**
 Optional(["CIAttributeFilterAvailable_iOS": 7, "CIAttributeFilterDisplayName": Vignette Effect, 
 
 "inputCenter": {
 CIAttributeClass = CIVector;
 CIAttributeDefault = "[150 150]";
 CIAttributeDescription = "The center of the effect as x and y coordinates.";
 CIAttributeDisplayName = Center;
 CIAttributeType = CIAttributeTypePosition;
 }, 
 
 "inputIntensity": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = 1;
 CIAttributeDescription = "The intensity of the effect.";
 CIAttributeDisplayName = Intensity;
 CIAttributeIdentity = 0;
 CIAttributeMax = 1;
 CIAttributeMin = "-1";
 CIAttributeSliderMax = 1;
 CIAttributeSliderMin = "-1";
 CIAttributeType = CIAttributeTypeScalar;
 }, 
 "inputImage": {
 CIAttributeClass = CIImage;
 CIAttributeDescription = "The image to use as an input image. For filters that also use a background image, this is the foreground image.";
 CIAttributeDisplayName = Image;
 CIAttributeType = CIAttributeTypeImage;
 }, "inputRadius": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = 150;
 CIAttributeDescription = "The distance from the center of the effect.";
 CIAttributeDisplayName = Radius;
 CIAttributeMin = 0;
 CIAttributeSliderMax = 2000;
 CIAttributeSliderMin = 0;
 CIAttributeType = CIAttributeTypeDistance;
 }, "inputFalloff": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = "0.5";
 CIAttributeDisplayName = Falloff;
 CIAttributeMax = 1;
 CIAttributeMin = 0;
 CIAttributeSliderMax = 1;
 CIAttributeSliderMin = 0;
 CIAttributeType = CIAttributeTypeScalar;
 }, "CIAttributeFilterAvailable_Mac": 10.9, "CIAttributeFilterName": CIVignetteEffect, "CIAttributeReferenceDocumentation": http://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVignetteEffect, "CIAttributeFilterCategories": <__NSArrayI 0x60000007e040>(
 CICategoryColorEffect,
 CICategoryVideo,
 CICategoryInterlaced,
 CICategoryStillImage,
 CICategoryBuiltIn
 )
 ])

 
 
 
 //Filters 1 and 2: Vignette Effect and Vignette
 /**
 let vignetteAttributes = [
 kCIInputImageKey: ciImage2,
 kCIInputIntensityKey: NSNumber(value: 10.30),
 kCIInputRadiusKey: NSNumber(value: 3.0)
 ]
 
 let vignetteFilterParameters = [
 kCIInputImageKey: ciImage1,
 kCIInputIntensityKey: NSNumber(value: 4.00),
 kCIInputRadiusKey: NSNumber(value: 1.00),
 kCIInputCenterKey: CIVector(cgPoint: CGPoint(x: 100, y: 100))
 
 ]
 
 let filter1 = CIFilter(name: "CIVignetteEffect", withInputParameters: vignetteFilterParameters)
 
 let filter2 = CIFilter(name: "CIVignette", withInputParameters: vignetteAttributes)
 
 //Filter 3: Color Invert
 let filter3Params = [
 kCIInputImageKey: ciImage3
 ]
 
 let filter3 = CIFilter(name: "CIColorInvert", withInputParameters: filter3Params)!
 
 **/
 
 //Category: Color Adjust
 
 
 
 //Filter 5: Tone Curve
 /**
 let toneCurveParams = [
 kCIInputImageKey: CIImage(cgImage: #imageLiteral(resourceName: "NationalPalace8").cgImage!)
 
 ]
 
 let toneCurveFilter = CIFilter(name: "CIToneCurve", withInputParameters: toneCurveParams)!
 
 toneCurveFilter.setDefaults()
 **/
 
 
 //Filter 6: Hue Adjust
 /**
 let filterAdjustParams = [
 kCIInputImageKey: CIImage(cgImage: #imageLiteral(resourceName: "NationalPalace8").cgImage!),
 kCIInputAngleKey: NSNumber(value: 90)
 ]
 
 let hueAdjustFilter = CIFilter(name: "CIHueAdjust", withInputParameters: filterAdjustParams)!
 
 **/
 
 
 
 
 // afterFilterImageView.image = UIImage(cgImage: cgImageRef!)
 
 
 //MARK: *********** Test for Different Generator Filters
 
 let color1 = CIColor(red: 0.50, green: 0.50, blue: 0.50)
 let color2 = CIColor(red: 0.50, green: 0.50, blue: 0.50)
 let cgRect = CGRect(x: 0, y: 0, width: 2000, height: 1500)
 let centerPoint = CIVector(x: 100, y: 50)
 
 //let cgImageRef = filterGenerator.generateStripedCGImage(withFirstStripeColorOf: color1, andSecondStripeColorOf: color2, width: 20.00, contrast: 20.00, cgRect: cgRect, centerPoint: centerPoint)!
 
 //let cgImageRef2 = filterGenerator.generateSunbeamCGImage(cgRect: cgRect, inputCenter: centerPoint, inputColor: color2, inputSunRadius: 20.0, inputMaxStriationRadius: 6.58, inputStriationStrength: 0.50, inputStriationContrast: 1.38, inputTime: 0.00)!
 
 //let cgImageRef3 = filterGenerator.generateLenticularHaloCGImage(cgRect: cgRect, inputCenter: centerPoint, inputColor: color1, inputHaloRadius: 15.00, inputHaloWidth: 27.00, inputHaloOverlap: 0.77, inputStriationStrength: 0.50, inputStriationContrast: 1.00, inputTime: 5.00)!
 
 //let cgImageRef4 = filterGenerator.generateCheckerboardCGImage(cgRect: cgRect, inputCenter: centerPoint, color1: color1, color2: color2, inputWidth: 20.00, inputSharpness: 1.00)!
 
 let cgImage = #imageLiteral(resourceName: "NationalPalaceFrontEntrance1").cgImage!
 let ciImage = CIImage(cgImage: cgImage)
 
 let cgImageRef5 = filterGenerator.generateBoxBlurCGImage(cgRect: cgRect, inputImage: ciImage, inputRadius: 30.0)!
 
 
 let vector = CIVector(x: 150, y: 150)
 let zoomBlurCIImage = BlurFilterGenerator.generateZoomBlurCIImage(inputImage: ciImage, inputCenter: vector, inputAmount: 10)!
 
 let motionBlurImage = BlurFilterGenerator.generateMotionBlurCIImage(inputImage: ciImage, inputRadius: 20.0, inputAngle: 20.0)!
 
 
 
 
 
 //let accordionImage = TransitionFilterGenerator.generateAccordionFoldTransition(inputImage: <#T##CIImage#>, inputTargetImage: <#T##CIImage#>)
 
 
 //afterFilterImageView.image = UIImage(ciImage: motionBlurImage)
 
 
 **/

