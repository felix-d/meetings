//
//  NewCommitteeController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class NewCommitteeController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
        
    @IBOutlet weak var committeeName: UITextField!
    @IBOutlet weak var participantsTable: UITableView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
   

   override func viewDidLoad() {
    
    //We set cancel button to parent view controller
    var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "popVC")
    self.navigationItem.leftBarButtonItem = cancelButton
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        appData.currentCommitteeAction = CommitteeAction.NEWCOMMITTEE
        
        //We reload participants data, each time after picking new ones
        participantsTable.reloadData()
        
        //If we just started editing, set label to "" and set pickerpositions to all positions
        if(!appData.startedEditingCommittee) {
            committeeName.text = ""
            appData.pickerPositions = appData.positions
        }
        
        checkForDoneButton()
        
        //we started editing
        appData.startedEditingCommittee = true
    }
    
     //We add a committee
    @IBAction func addCommittee(sender: UIBarButtonItem) {
        
        //we initialize the committee with its name and participants
        
        var committee: Committee = Committee(name: committeeName.text, pos: appData.tempParticipants)
        
        //we add to appData
        appData.addCommittee(committee)
    
        appData.startedEditingCommittee = false;
        
        //we go back to committees or home page if first use
        self.navigationController?.popViewControllerAnimated(true)
    }


    //Go to parent view controller
    func popVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    //Return when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        if(appData.hintAddParticipants == Hint.SHOW){
            var alert = UIAlertController(title: "Notice", message: "Now give your committee a name and add participants to it!", preferredStyle: UIAlertControllerStyle.Alert)
            var alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            appData.hintAddParticipants = Hint.HIDE
        }
    }
    //Check for done button when we did end editing
    func textFieldDidEndEditing(textField: UITextField) {
        
       checkForDoneButton()
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.committeeName.resignFirstResponder()
    }
       
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.tempParticipants.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ParticipantsCell = tableView.dequeueReusableCellWithIdentifier("newparticipant", forIndexPath: indexPath) as ParticipantsCell
        cell.setCell(indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            appData.pickerPositions.append(appData.tempParticipants[indexPath.row])
            appData.tempParticipants.removeAtIndex(indexPath.row)
            participantsTable.reloadData()
            checkForDoneButton()
            
        }
    }
    
    func checkForDoneButton(){
        if(appData.tempParticipants.isEmpty || committeeName.text == "") {
            self.navigationItem.rightBarButtonItem?.enabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
    }


}
