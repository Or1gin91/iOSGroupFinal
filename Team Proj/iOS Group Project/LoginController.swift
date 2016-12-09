//
//  ViewController.swift
//  LoginSignUp
//
//  Created by Mark Chirino on 12/6/16.
//  Copyright © 2016 FIUFiu. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var accounts: Accounts?
    private var account: Account?
    private var authenticated = false
    
    @IBOutlet var txtUsername: UITextField!

    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the Accounts class
        accounts = Accounts()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        accounts = Accounts()
    }
    
    
    @IBAction func loginPressed(sender: AnyObject) {
        
        if let checkAccount = accounts?.checkAccount(txtUsername.text!, password: txtPassword.text!) {
            //Account authenticated perform segue
            self.account = checkAccount
            authenticated = true
            performSegueWithIdentifier("showLanding", sender: self)
        }
        else {
            let ac = UIAlertController(title: "Authentication", message: "Authentication Failed Please Try Again", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            ac.addAction(okAction)
            presentViewController(ac, animated: true, completion: {
                self.txtUsername.text = ""
                self.txtPassword.text = ""
            })
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSignUp" {
            let signUpController = segue.destinationViewController as! SignUpController
            signUpController.accounts = accounts
        }
        if segue.identifier == "showLanding" && authenticated {
            //auth worked send to the landing page pass account references
            let barController = segue.destinationViewController as! UITabBarController
            let nav = barController.viewControllers![0] as! UINavigationController
            let destController = nav.topViewController as! Profile
            destController.account = self.account
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}