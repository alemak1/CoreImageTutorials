//
//  ModalMapView.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class ModalMapViewController: UIViewController{
    
    
    enum MapType: Int{
        case StartingPoint = 2
        case Destination = 1
        case None = 0
    }
    
    var mapView: MKMapView!
    var mapType: MapType!
    
    let dismissButtonTapGR = UITapGestureRecognizer(target: self, action: #selector(ModalMapViewController.dismissModalMapViewController))
    
    lazy var dimissButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.roundedRect)
        button.contentEdgeInsets = UIEdgeInsets(top: 2.00, left: 2.00, bottom: 2.00, right: 2.00)
        button.setTitle("Back", for: .normal)
        
        return button
    
    }()
    
    
    
    init(mapView: MKMapView, mapType: MapType){
        
        self.mapView = MKMapView()
        self.mapView.region = MKCoordinateRegion(center: mapView.region.center, span: mapView.region.span)
        
        self.mapView.addAnnotations(mapView.annotations)
        self.mapType = mapType
        
        super.init(nibName: nil, bundle: nil)
        self.mapView.delegate = self

    }
    
    convenience init() {
        let defaultMapView = MKMapView()
        self.init(mapView: defaultMapView, mapType: .None)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillLayoutSubviews() {
        configureMapViewConstraints()
        configureDismissButton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // addPreConfiguredAnnotations()
    }
    
    
    func addPreConfiguredAnnotations(){
        
        let lat1 = 13.737718
        let long1 = 100.560350
        let location1 = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        let touristSpot1 = TouristSpot(coordinate: location1, title: "Terminal 21", subtitle: "Shopping Center", siteDescription: "A great place to go shopping")
        
        
        let lat2 = 13.737009
        let long2 = 100.560388
        let location2 = CLLocationCoordinate2D(latitude: lat2, longitude: long2)
        let touristSpot2 = TouristSpot(coordinate: location2, title: "Asok Station", subtitle: "BTS(SkyTrain) Station", siteDescription: "A stop on Bangkok's BTS SkyTrain")
        
        let lat3 = 13.737561
        let long3 = 100.559165
        let location3 = CLLocationCoordinate2D(latitude: lat3, longitude: long3)
        let touristSpot3 = TouristSpot(coordinate: location3, title: "Sheraton Hotel", subtitle: "5-Star Hotel", siteDescription: "A 5-star hotel with beautiful accomdations and also connected directly to the subway station")
        
        let lat4 = 13.737764
        let long4 = 100.558789
        let location4 = CLLocationCoordinate2D(latitude: lat4, longitude: long4)
        let touristSpot4 = TouristSpot(coordinate: location4, title: "Times Square Shopping Mall", subtitle: "A great place to go shopping", siteDescription: "A high-end shopping mall with a food court in the basement")
        
        mapView.addAnnotation(touristSpot1)
        mapView.addAnnotation(touristSpot2)
        mapView.addAnnotation(touristSpot3)
        mapView.addAnnotation(touristSpot4)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        self.dimissButton.addGestureRecognizer(dismissButtonTapGR)


        //let annotationView1 = MKAnnotationView(annotation: <#T##MKAnnotation?#>, reuseIdentifier: <#T##String?#>)
    }
    
    
    private func configureDismissButton(){
        view.addSubview(dimissButton)
        
        self.dimissButton.translatesAutoresizingMaskIntoConstraints = false
        
      
        NSLayoutConstraint.activate([

            dimissButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10),
            dimissButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
            dimissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dimissButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10)
            ])
        
        
    }
    
    private func configureMapViewConstraints(){
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /**
            mapView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0.00),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.00),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.00),
            mapView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0.00)
            **/
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95)
            
            ])
    }
    
    @objc func dismissModalMapViewController(sender: UITapGestureRecognizer){
        self.navigationController?.popToRootViewController(animated: true)
        
        
        let userInfo = [
            
            "UpdatedLatitude": mapView.region.center.latitude,
            "UpdatedLongitude": mapView.region.center.longitude,
            "UpdatedLatitudeDelta": mapView.region.span.latitudeDelta,
            "UpdatedLongitudeDelta": mapView.region.span.longitudeDelta,
            "UpdatedMapType": self.mapType.rawValue
         ] as [String : Any]
        
        let notificationName = Notification.Name(rawValue: "updateMapViewNotification")
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        
        let userInfo = [
            
            "UpdatedLatitude": mapView.region.center.latitude,
            "UpdatedLongitude": mapView.region.center.longitude,
            "UpdatedLatitudeDelta": mapView.region.span.latitudeDelta,
            "UpdatedLongitudeDelta": mapView.region.span.longitudeDelta,
            "UpdatedMapType": self.mapType.rawValue
            ] as [String : Any]
        
        let notificationName = Notification.Name(rawValue: "updateMapViewNotification")
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
        
        super.willMove(toParentViewController: parent)
    }
    
}


extension ModalMapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        
    }
}


