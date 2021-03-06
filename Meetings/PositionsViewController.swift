//
//  PositionsViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class PositionsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        
        newPositionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newposition") as UIViewController
        editPositionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editposition") as UIViewController
        firstViewController = self.storyboard?.instantiateViewControllerWithIdentifier("first") as UIViewController
        
        
        var add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "goToNewPositionView")
        
        
        
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.title = "Salary Levels"
        self.navigationItem.leftBarButtonItem?.title = "Cancel"
        self.navigationItem.backBarButtonItem?.title = "Cancel"

    }
    
    
    override func viewWillAppear(animated: Bool) {
        
            self.tableView.reloadData()
        
        //Des que l'utilisateur rajoute une position, premiere utilisation
        if appData.positions.count == 1 && appData.committees.count == 0 {
            if appData.hintFirstPosition == Hint.SHOW {
                appData.hintFirstPosition == Hint.HIDE
                var alert = UIAlertController(title: "Notice", message: "When you have enough salary levels press next!", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
                var nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Bordered, target: self, action: "popToHome")
            
            self.navigationItem.leftBarButtonItem = nextButton
        }
        
        
    }
    
    
    func popToHome(){
        println("pop")
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidAppear(animated: Bool) {
        if(appData.hintPositions == Hint.SHOW){
            var alert = UIAlertController(title: "Notice", message: "You can always edit or delete salary levels by swiping cells left!", preferredStyle: UIAlertControllerStyle.Alert)
            var alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            appData.hintPositions = Hint.HIDE
        }
      
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.positions.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("positioncell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = appData.positions[indexPath.row].name
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
            
            appData.removePosition(indexPath.row)
            appData.refreshCommittees()
            self.tableView.reloadData()
        });

        var edit = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{action, indexpath in
            
            appData.positionId = appData.positions[indexPath.row].id
            self.goToEditPositionView()

        });
        
        
        edit.backgroundColor = UIColor.grayColor()
        return [delete, edit]
    }

    func goToEditPositionView(){
        self.navigationController?.pushViewController(editPositionViewController, animated: true)
    }
    func goToNewPositionView(){
        self.navigationController?.pushViewController(newPositionViewController, animated: true)
    }
    

}
