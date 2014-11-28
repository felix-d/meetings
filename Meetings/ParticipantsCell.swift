//
//  ParticipantsCell.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-24.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class ParticipantsCell: UITableViewCell {

    //For the edit committee view
    @IBOutlet weak var editQuantity: UILabel!
    @IBOutlet weak var editFunctionName: UILabel!
    @IBOutlet weak var editStepper: UIStepper!
    
    //For the new committee view
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var functionName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    var index = 0
    
    //When the stepper changes for edit committee view
    @IBAction func editStepChanges(sender: UIStepper) {
        appData.tempParticipants[index].qty = Int(sender.value)
        self.editQuantity.text = Int(sender.value).description
    }
    
     //When the stepper changes for new committee view
    @IBAction func stepChanges(sender: UIStepper) {
        appData.tempParticipants[index].qty = Int(sender.value)
        self.quantity.text = Int(sender.value).description

    }
    
    //Here set Cell is used by 2 different controllers, hence the double assignments
    func setCell(i: Int) {
        
        index = i
        
        switch appData.currentCommitteeAction {
            
        //In the case of new committee controller
        case CommitteeAction.NEWCOMMITTEE:
            
            //we set the stepper value (set to 1 in position contructor)
            self.stepper.value = Double(appData.tempParticipants[i].qty)
            
            //we set function name
            self.functionName.text = appData.tempParticipants[i].name
            
            //we set quantity
            self.quantity.text = String(appData.tempParticipants[i].qty)
            break
    
        //In the case of edit committee controller
        case CommitteeAction.EDITCOMMITTEE:
            
            //we set the stepper value to current quantity of the salary levels
             self.editStepper.value = Double(appData.tempParticipants[i].qty)
             
             //we edit the function name
             self.editFunctionName.text = appData.tempParticipants[i].name
             
             //we set the quantity text
             self.editQuantity.text = String(appData.tempParticipants[i].qty)
            break
            
        //whatever...
        default:
            break
        }
        
        
    }
}
