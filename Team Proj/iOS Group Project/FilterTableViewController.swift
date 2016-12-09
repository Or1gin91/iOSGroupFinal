//
//  FilterTableViewController.swift
//  iOS Group Project
//
//  Created by Mark Chirino on 12/8/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var pinDB = PinDB.sharedInstance
    var filter: String?
    var matchedPins = [Pin]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "Filter: \(filter)"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for pin in pinDB.allPins {
            if pin.type == filter {
                matchedPins.append(pin)
                count += 1
            }
            
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let pin = matchedPins[indexPath.row]
        cell.textLabel?.text = pin.title
        cell.detailTextLabel?.text = pin.desc
        
        return cell
    }
    
    
}
