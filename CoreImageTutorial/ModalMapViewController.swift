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
        self.mapType = mapType
        
        super.init(nibName: nil, bundle: nil)
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
    
    override func didMove(toParentViewController parent: UIViewController?) {
        self.dimissButton.addGestureRecognizer(dismissButtonTapGR)

    
        
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




