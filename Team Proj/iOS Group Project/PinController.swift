//
//  pinController.swift
//  iOS Group Project
//
//  Created by Matthew Womack on 12/6/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import UIKit
import MapKit
import Social

class PinController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {
        
    @IBOutlet var txtPinTitle: UITextField!
    @IBOutlet var txtPinDesc: UITextField!
    @IBOutlet var lblPinType: UILabel!
    @IBOutlet var btnShare: UIButton!
    
    //These variable will be filled from the calling controller depending on whether it is a new pin or pin detail view
    var pin: Pin?
    var pinDB: PinDB?
    var pinCoords: CLLocationCoordinate2D?
    var isNewPin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //Check if this is a pin detail view or a new pin edit screen
        
        if !isNewPin {
            changeTxtBorderDispaly()
            //display pin details in the text fields
            navigationItem.title = pin?.title
            txtPinTitle.text = pin?.title
            txtPinDesc.text = pin?.desc
            lblPinType.text = pin?.type
        }
        else if isNewPin {
            navigationItem.title = "New Pin"
            self.editing = true
            
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if editing {
            changeTxtBorderEdit()
            self.view.setNeedsDisplay()
            self.btnShare.hidden = true
            super.setEditing(true, animated: animated)
        }
        else {
            super.setEditing(false, animated: animated)
            changeTxtBorderDispaly()
            self.btnShare.hidden = false
            self.view.endEditing(true)
            if isNewPin {
                saveNewPin()
            }
            else {
                updateCurrentPin()
            }
            navigationItem.title = pin?.title
            //self.view.setNeedsDisplay()
        }
        
    }

    
    //Change editing fields functions
    func changeTxtBorderEdit() {
        txtPinDesc.borderStyle = .RoundedRect
        txtPinTitle.borderStyle = .RoundedRect
    }
    
    func changeTxtBorderDispaly() {
        txtPinTitle.borderStyle = .None
        txtPinDesc.borderStyle = .None
    }
    
    //Allow txtfields to edit when in editing
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if editing {
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: Methods to save and update pins
    
    func saveNewPin() {
        pin = Pin(title: txtPinTitle.text!, coordinate: pinCoords!, desc: txtPinDesc.text!, type: lblPinType.text!, comments: nil)
        pinDB?.allPins.append(pin!)
    }
    
    func updateCurrentPin() {
        //Update the pin in the PinDB and copy the updated version back into the pin variable
        let index = pinDB!.allPins.indexOf(pin!)
        pinDB!.allPins[index!].title = txtPinTitle.text!
        pinDB!.allPins[index!].desc = txtPinDesc.text!
        pinDB!.allPins[index!].type = lblPinType.text!
        pin = pinDB!.allPins[index!]
    }

    //MARK: Method to validate text fields
    func validateTextFields() {
        
    }
    
    //MARK: Select Type Button Click event handler
    @IBAction func btnType_Click(sender: AnyObject) {
        if editing {
            let ac = UIAlertController(title: "Type Selection", message: "Please Select a Type of Pin", preferredStyle: .Alert)
            let shopAction = UIAlertAction(title: "Shop", style: .Default) { (action) -> Void in
                self.lblPinType.text = "Shop"
            }
            let eventAction = UIAlertAction(title: "Event", style: .Default) { (action) -> Void in
                self.lblPinType.text = "Event"
            }
            let pilotAction = UIAlertAction(title: "Pilot", style: .Default) { (action) -> Void in
                self.lblPinType.text = "Pilot"
            }
            ac.addAction(shopAction)
            ac.addAction(eventAction)
            ac.addAction(pilotAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    //MARK: Share button
    
    @IBAction func btnShare_Clicked(sender: AnyObject) {
        if !editing{
            let ac = UIAlertController(title: "Share", message: "Pick a Social Media Outlet", preferredStyle: .Alert)
            let fbAction = UIAlertAction(title: "FaceBook", style: .Default) { (UIAlertAction) in
                //display other alert controller
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    var facebookSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookSheet.setInitialText("Check out this spot at \(self.pinCoords?.latitude) & \(self.pinCoords?.longitude)")
                    self.presentViewController(facebookSheet, animated: true, completion: nil)
                }
            }
            let twitterAction = UIAlertAction(title: "Twitter", style: .Default) { (UIAlertAction) in
                //display other alert controller
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                    var twitterSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    twitterSheet.setInitialText("Check out this spot at \(self.pinCoords?.latitude) & \(self.pinCoords?.longitude)")
                    self.presentViewController(twitterSheet, animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(fbAction)
            ac.addAction(twitterAction)
            ac.addAction(cancelAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    
    
}
