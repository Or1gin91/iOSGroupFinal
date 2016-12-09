//
//  MapViewController.swift
//  iOS Group Project
//
//  Created by Mark Chirino on 12/7/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    var pinDB: PinDB?
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D()
    var isNewPin = false
    var pin: Pin?
    var filter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        //Create a TapGesture recognizer for creating pins
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "mapTap:")
        gestureRecognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        pinDB = PinDB.sharedInstance
        isNewPin = false
        mapView.addAnnotations(pinDB!.allPins as [MKAnnotation])
    }
    
    //Mapview Delegate Functions
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequedView.annotation = annotation
                view = dequedView
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.pin = view.annotation as! Pin
        performSegueWithIdentifier("showPinDetail", sender: self)
        
        
        
    }
    
    
    
    //Location delegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    //Function that is called when gesture is recognized on map
    func mapTap(gestureRecognizer: UIGestureRecognizer) {
        print("longpressfired")
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = gestureRecognizer.locationInView(mapView)
            var newCoordinates = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
            coords = newCoordinates
            isNewPin = true
            performSegueWithIdentifier("showPinDetail", sender: self.view)
            
        }
        
        

    }
    
    //Pass data with segue to pin detail controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPinDetail" {
            let pc = segue.destinationViewController as! PinController
            pc.pinCoords = coords
            pc.isNewPin = isNewPin
            pc.pinDB = self.pinDB
            if !(isNewPin){
                pc.pin = pin
                
            }
            
        }
        if segue.identifier == "showFilter" {
            
            let filterController = segue.destinationViewController as! FilterTableViewController
            filterController.filter = self.filter
            print("i am in segue filter")
            
        }
    }
    
    @IBAction func btnFilter_Clicked(sender: AnyObject) {
        let ac = UIAlertController(title: "Type Selection", message: "Please Select a Type of Pin", preferredStyle: .Alert)
        let shopAction = UIAlertAction(title: "Shop", style: .Default) { (action) -> Void in
            self.filter = "Shop"
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
                self.performSegueWithIdentifier("showFilter", sender: self)
            }
        }
        let eventAction = UIAlertAction(title: "Event", style: .Default) { (action) -> Void in
            self.filter = "Event"
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
                self.performSegueWithIdentifier("showFilter", sender: self)
            }
        }
        let pilotAction = UIAlertAction(title: "Pilot", style: .Default) { (action) -> Void in
            self.filter = "Pilot"
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
                self.performSegueWithIdentifier("showFilter", sender: self)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        ac.addAction(shopAction)
        ac.addAction(eventAction)
        ac.addAction(pilotAction)
        ac.addAction(cancelAction)
        presentViewController(ac, animated: true) {
            
        }
        
        
        
    }

    

    
}
