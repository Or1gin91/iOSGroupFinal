//
//  Profile.swift
//  iOS Group Project
//
//  Created by Matthew Womack on 12/7/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import UIKit

class Profile: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet var taps: UITapGestureRecognizer!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var txtAboutMe: UITextView!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var btnHangar: UIButton!
    
    //Variable to hold logged in Account
    var account: Account?
    //use account get methods to retrieve the logged in users info...no direct access to these variables since they need to be static
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(account?.getFName())
    }
    
    //Set up Profile Page fields based on the current account
    override func viewWillAppear(animated: Bool) {
        if account!.hasProfilePic() {
            self.imageView.image = account?.getProfilePic() as? UIImage
        }
        self.txtFName.text = account?.getFName()
        self.txtLName.text = account?.getLName()
        self.txtAboutMe.text = account?.getAboutMe()
        self.txtType.text = account?.getType()
    }
    
    //Save any changes made to the about me section
    override func viewWillDisappear(animated: Bool) {
        account?.setAboutMe(self.txtAboutMe.text)
    }
    
    //This will allow the user to take a picture after the button has been pressed
    @IBAction func cameraPressed(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //This will take whatever picture the user took with the camera and save it to their account and populate the imageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
        account?.setProfilePic((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
