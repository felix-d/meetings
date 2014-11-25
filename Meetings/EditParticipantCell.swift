//
//  EditParticipantCell.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-24.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class EditParticipantCell: UITableViewCell {
    
        @IBOutlet weak var myStepper: UIStepper!
        @IBOutlet weak var functionName: UILabel!
        @IBOutlet weak var quantity: UILabel!
        var index = 0
        
        
        @IBAction func stepChanges(sender: UIStepper) {
            appData.tempParticipants[index].qty = Int(sender.value)
            self.quantity.text = Int(sender.value).description
            
        }
        func setCell(i: Int) {
            index = i
            self.myStepper.value = Double(appData.tempParticipants[i].qty)
            self.functionName.text = appData.tempParticipants[i].name
            self.quantity.text = String(appData.tempParticipants[i].qty)

        }
}


