//
//  MeetingsViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class CommitteesViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var myTable: UITableView!
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        newCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newcommittee") as UIViewController
        editCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editcommittee") as UIViewController
        var add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "goToNewCommitteeView")
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.title = "Committees"
    }
    
    //ON CLEAR TEMPPARTICIPANTS QUAND ON REVIENT
    override func viewDidAppear(animated: Bool) {
          appData.clearTemp()
    }
    
    //ON RELOAD LE DATA
    override func viewWillAppear(animated: Bool) {
        appData.startedEditingCommittee = false
        self.myTable.reloadData()
    }
    
    //GO TO NEW COMMITTEE VIEW
    func goToNewCommitteeView(){
        self.navigationController?.pushViewController(newCommitteeViewController, animated: true)    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.committees.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellcommittee", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = appData.committees[indexPath.row].name
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            appData.removeCommittee(indexPath.row)
            self.tableView.reloadData()
        });
        
        var edit = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{action, indexpath in
            appData.committeeIndex = indexPath.row
            self.goToEditCommitteeView()
            
        });
        
        
        edit.backgroundColor = UIColor.grayColor()
        return [delete, edit]
    }
    
    
    func goToEditCommitteeView(){
        self.navigationController?.pushViewController(editCommitteeViewController, animated: true)
    }



}
