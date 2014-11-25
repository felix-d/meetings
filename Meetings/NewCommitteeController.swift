//
//  NewCommitteeController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class NewCommitteeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
        
    @IBOutlet weak var committeeName: UITextField!
    @IBOutlet weak var participantsTable: UITableView!
    
    //We add a committee
    @IBAction func addCommittee(sender: UIBarButtonItem) {
        
        //we initialize the committee with its name and participants
        var committee: Committee = Committee(name: committeeName.text, pos: appData.tempParticipants)
        
        //we add to appData
        appData.addCommittee(committee)
        
        //we clear temp data
        appData.clearTemp()
        
        //we go back to committees
        self.navigationController?.popViewControllerAnimated(true)
    }
    



   override func viewDidLoad() {
        //We change state to use right picker
    
    }
    
    override func viewDidDisappear(animated: Bool) {
      
    }
    
    override func viewWillAppear(animated: Bool) {
         appData.currentState = state.NEWCOMMITTEE
        //We reload participants data
        participantsTable.reloadData()
        
        //If we just started editing, set label to "" and set pickerpositions to all positions
        if(!appData.startedEditingCommittee) {
            committeeName.text = ""
            appData.pickerPositions = appData.positions
        }
        
        //we started editing
        appData.startedEditingCommittee = true
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
            
        }
    }


}
