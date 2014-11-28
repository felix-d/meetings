//
//  SecondViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-22.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var settings = ["Committees", "Salary Levels"]
        
    override func viewDidLoad() {
        
        appData.hintPositions = Hint.SHOW
        appData.hintCommittees = Hint.SHOW
        appData.hintEditCommittee = Hint.SHOW
        super.viewDidLoad()
        committeesViewController = storyboard?.instantiateViewControllerWithIdentifier("committees") as UIViewController
        positionsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("positions") as UIViewController
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = settings[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Committees and salary levels"
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0) {
            self.navigationController?.pushViewController(committeesViewController, animated: true)
        } else {
            self.navigationController?.pushViewController(positionsViewController, animated: true)
        }
    }


}

