//
//  EditCommitteeController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-24.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class EditCommitteeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

 
   
    @IBOutlet weak var participantsTable: UITableView!
    @IBOutlet weak var committeeName: UITextField!
    
    
    override func viewDidLoad() {
        
        //We set the navigation title
        self.navigationItem.title = "Edit Committee"
        
        //We set the left navigation button to cancel, which calls popToHome()
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "popToHome")
        self.navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    //We go back to home
    func popToHome(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //We start editing a committee
        appData.currentCommitteeAction = CommitteeAction.EDITCOMMITTEE
        
        //If we come from committee controller
        if !appData.startedEditingCommittee {
            
            //We set the participants to fill the table with the current committee salary levels
            if let x = appData.getCurrentCommitte()?.positions {
                 appData.tempParticipants = x
            }
            
            //we set the text field to the name of the committee
            if let x = appData.getCurrentCommitte()?.name {
                appData.tempCommitteeName = x
            }
            
            //we set the picker positions
            if let x = appData.getCurrentCommitte()? {
                appData.pickerPositions = appData.getRemainingPositions(x)
            }
        }
        
        //stays true while we aren't back to first page or committees controller
        appData.startedEditingCommittee = true
        
        //We reload data because we might have added a participant from the picker
        participantsTable.reloadData()
        
        //we set the committee name when we're back from picker
        self.committeeName.text = appData.tempCommitteeName
        
    }
    
    //Return keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        committeeName.resignFirstResponder()
        return true
    }
    
    //Done button action
    @IBAction func doneEditing(sender: UIBarButtonItem) {
        
        //We modify the current committee
        appData.modifyCurrentCommittee(self.committeeName.text, ps: appData.tempParticipants)
        
        //Pop the view to go back to Committee Controller
        self.navigationController?.popViewControllerAnimated(true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.tempParticipants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EditParticipantCell = tableView.dequeueReusableCellWithIdentifier("newparticipantedit", forIndexPath: indexPath) as EditParticipantCell
        cell.setCell(indexPath.row)
        return cell
    }
    
    //lorsqu'on supprime un participant
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            //Add participant to picker
            appData.pickerPositions.append(appData.tempParticipants[indexPath.row])
            
            //Sort picker
            appData.pickerPositions.sort({$0.name > $1.name})
            
            //Remove participant from lobby
            appData.tempParticipants.removeAtIndex(indexPath.row)
           
            //Reload participants table data
            participantsTable.reloadData()
            
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
