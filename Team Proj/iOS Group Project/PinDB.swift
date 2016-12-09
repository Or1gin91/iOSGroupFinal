//
//  PinDB.swift
//  iOS Group Project
//
//  Created by Mark Chirino on 12/7/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import Foundation
import MapKit

class PinDB {
    //This Class will hold a collection of Pin classes
    
    static let sharedInstance = PinDB()
    
    var allPins = [Pin]()
    
    private init() {
        
        //This method will create a list of test pins programmatically around FIU for presentation purposes
        
        allPins.append(Pin(title: "FIU Hobby Shop", coordinate: CLLocationCoordinate2D(latitude: 25.745505, longitude: -80.382078), desc: "Hobby Shop for all your Hobby Needs.", type: "Shop", comments: ["Awesome Service", "Best in town", "Highly Recommended"]))
        allPins.append(Pin(title: "FIU Hobby Event", coordinate: CLLocationCoordinate2D(latitude: 25.754216, longitude: -80.366199), desc: "Hobby Race at 3:00PM", type: "Event", comments: ["Cant wait to race", "Excited for the race"]))
        allPins.append(Pin(title: "Cool Spot", coordinate: CLLocationCoordinate2D(latitude: 25.765981, longitude: -80.381681), desc: "Nice spot to fly at.", type: "Spot", comments: ["Great Aerial Shots", "Park lets us fly here!"]))
    }
    
    
    
}
