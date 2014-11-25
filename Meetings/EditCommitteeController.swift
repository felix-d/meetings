//
//  EditCommitteeController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-24.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class EditCommitteeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
   
    @IBOutlet weak var participantsTable: UITableView!
    
    @IBOutlet weak var committeeName: UITextField!
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Edit Committee"
        
        
    }
    override func viewWillAppear(animated: Bool) {
        appData.currentState = state.EDITCOMMITTEE
        //If we come from committee controller
        if !appData.startedEditingCommittee {
            
            //We set the participants to the committee participants
            appData.tempParticipants = appData.committees[appData.committeeIndex].getPositions()
            
            //we set the text field to the name of the committee
            appData.tempCommitteeName = appData.committees[appData.committeeIndex].name
            
            println(appData.committees[appData.committeeIndex].positions.count)
            //we set the picker positions
            appData.pickerPositions = appData.getRemainingPositions(appData.committees[appData.committeeIndex])
        }
        
        //stays true while we aren't back to first page or committees controller
        appData.startedEditingCommittee = true
        
        //We reload data because we might have added a participant from the picker
        participantsTable.reloadData()
        
        //we set the committee name when we're back from picker
        self.committeeName.text = appData.tempCommitteeName
        
    }
    
    //Done button action
    @IBAction func doneEditing(sender: UIBarButtonItem) {
        //We replace the old positions with the new positions
        appData.committees[appData.committeeIndex].positions = appData.tempParticipants
        
        //We replace the committee name
        appData.committees[appData.committeeIndex].name = self.committeeName.text
        
        //We sort the positions in the committee
        appData.committees[appData.committeeIndex].positions.sort({$0.name > $1.name})
        
        //We clear temporary data
        appData.clearTemp()
        
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
}
