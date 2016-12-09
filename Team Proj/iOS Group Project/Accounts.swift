//
//  Accounts.swift
//  LoginSignUp
//
//  Created by Mark Chirino on 12/6/16.
//  Copyright © 2016 FIUFiu. All rights reserved.
//

import UIKit
import CoreData

class Accounts {
    
    var accounts = [NSManagedObject]()
    
    required init() {
        
        //Load up the accounts array from coredata
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //managedContext.reset()
        
        let fetchRequest = NSFetchRequest(entityName: "Account")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            accounts = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func saveAccount(fName: String, lName: String, userName: String, password: String, type: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Account", inManagedObjectContext: managedContext)
        
        let account = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        account.setValue(fName, forKey: "firstName")
        account.setValue(lName, forKey: "lastName")
        account.setValue(userName, forKey: "userName")
        account.setValue(password, forKey: "password")
        account.setValue(type, forKey: "type")
        
        do {
            try managedContext.save()
            //save the account in the class to be able to access it
            accounts.append(account)
        } catch let error as NSError {
            print ("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func checkAccount(userName: String, password: String) -> Account? {
        //find account
        print(accounts.count)
        for i in 0..<accounts.count {
            if (accounts[i].valueForKey("userName") as! String == userName)
            {
                //username matches
                //check password
                if (accounts[i].valueForKey("password") as! String == password)
                {
                    //password matches
                    let fName = accounts[i].valueForKey("firstName") as! String
                    let lName = accounts[i].valueForKey("lastName") as! String
                    let userName = accounts[i].valueForKey("userName") as! String
                    let type = accounts[i].valueForKey("type") as! String
                    return Account(fName: fName, lName: lName, userName: userName, type: type)
                }
            }
        }
        return nil
    }
    
    
    
    
}