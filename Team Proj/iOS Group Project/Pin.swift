//
//  Pin.swift
//  MapTest
//
//  Created by Mark Chirino on 12/7/16.
//  Copyright © 2016 FIUFiu. All rights reserved.
//

import MapKit

class Pin: NSObject, MKAnnotation {
    
    var title: String? //Required title variable when inheriting from MKAnnotation
    var coordinate: CLLocationCoordinate2D //Will hold the pin coordinates
    var desc: String //Description that will appear on the pin detail screen
    var type: String //String to hold the type of the Pin(Shop, Pilot, Event)
    private var comments = [String]() //Array of string to hold comments(may not be implemented yet)
    
    
    init(title: String, coordinate: CLLocationCoordinate2D, desc: String, type: String, comments: [String]?) {
        self.title = title
        self.coordinate = coordinate
        self.desc = desc
        self.type = type
        if comments != nil {
            self.comments = comments!
        }
    }
    
    func addComment(comment: String) {
        //This function adds a comment to the comments array
        comments.append(comment)
    }
    
    func getComments() -> [String] {
        //Return comments as array of strings
        return comments
    }
    
}