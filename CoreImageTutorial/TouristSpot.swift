//
//  TouristSpots.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import MapKit

class TouristSpot: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, siteDescription: String? = nil){
        self.coordinate = coordinate
        
        if let siteTitle = title{
            self.title = siteTitle
        }
        
        if let siteSubtitle = subtitle{
            self.subtitle = siteSubtitle
        }
        
        if let siteDescription = siteDescription{
            self.siteDescription = siteDescription
        }
        
    }
    
   
    
    var title: String?
    var subtitle: String?
    var siteDescription: String?
}
