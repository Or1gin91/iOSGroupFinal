//
//  SignUpViewController.swift
//  LoginSignUp
//
//  Created by Mark Chirino on 12/6/16.
//  Copyright © 2016 FIUFiu. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtFname: UITextField!
    
    @IBOutlet var txtLname: UITextField!
    
    @IBOutlet var txtUsername: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var txtType: UILabel!
    
    var accounts: Accounts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // present modal alert to pick type of account
        if (textField.tag == 9) {
            let ac = UIAlertController(title: "Type", message: "Pick a Type", preferredStyle: .ActionSheet)
            
            let pilotAction = UIAlertAction(title: "Pilot", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Pilot"
            }
            
            let eventAction = UIAlertAction(title: "Event Coordinator", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Event Coordinator"
            }
            
            let shopAction = UIAlertAction(title: "Shop Owner", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Shop Owner"
            }
            
            ac.addAction(pilotAction)
            ac.addAction(eventAction)
            ac.addAction(shopAction)
            
            presentViewController(ac, animated: true, completion: nil)
            
            return false
        }
        return true
        
    }
    
    @IBAction func btnType_Clicked(sender: AnyObject) {
        // present modal alert to pick type of account
            let ac = UIAlertController(title: "Type", message: "Pick a Type", preferredStyle: .Alert)
            
            let pilotAction = UIAlertAction(title: "Pilot", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Pilot"
            }
            
            let eventAction = UIAlertAction(title: "Event Coordinator", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Event Coordinator"
            }
            
            let shopAction = UIAlertAction(title: "Shop Owner", style: .Default) { (action) -> Void in
                //Set the txtType field
                self.txtType.text = "Shop Owner"
            }
            
            ac.addAction(pilotAction)
            ac.addAction(eventAction)
            ac.addAction(shopAction)
            
            presentViewController(ac, animated: true, completion: nil)
        
    }
    
    @IBAction func submitAccount(sender: AnyObject) {
        
        //Call the save method in accounts
        print(txtFname.text)
        print(txtLname.text)
        print(txtUsername.text)
        print(txtPassword.text)
        print(txtType.text)
        
        accounts!.saveAccount(txtFname.text!, lName: txtLname.text!, userName: txtUsername.text!, password: txtPassword.text!, type: txtType.text!)
        print(accounts!.accounts)
    }
    
}