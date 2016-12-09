//
//  Account.swift
//  iOS Group Project
//
//  Created by Mark Chirino on 12/8/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import Foundation

class Account {
    private var fName: String
    private var lName: String
    private var userName: String
    private var type: String
    private var profilePic: AnyObject?
    private var aboutMe: String? = "No 'About Me' information found. Please add information here..."
    
    required init(fName: String, lName: String, userName: String, type: String) {
        self.fName = fName
        self.lName = lName
        self.userName = userName
        self.type = type
    }
    
    func getFName() -> String {
        return self.fName
    }
    
    func getLName() -> String {
        return self.lName
    }
    
    func getUserName() -> String {
        return self.userName
    }
    
    func getType() -> String {
        return self.type
    }
    
    func setProfilePic(aPic: AnyObject) {
        self.profilePic = aPic
    }
    
    func getProfilePic() -> AnyObject {
        return self.profilePic!
    }
    
    func hasProfilePic() -> Bool {
        if self.profilePic != nil {
            return true
        }
        return false
    }
    
    func getAboutMe() -> String {
        return self.aboutMe!
    }
    
    func setAboutMe(aStr: String) {
        self.aboutMe = aStr
    }
}
