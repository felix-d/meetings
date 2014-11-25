//
//  EditPositionViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class EditPositionViewController: UIViewController {

    @IBOutlet weak var positionName: UITextField!
    @IBOutlet weak var salary: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        //We update textfields of current positionID
        positionName.text = appData.getPosition(appData.positionId)!.name
        salary.text = String(appData.getPosition(appData.positionId)!.salary)
    }
    
    @IBAction func Editposition(sender: AnyObject) {
        
        //We update the position
        appData.getPosition(appData.positionId)!.name = positionName.text
        appData.getPosition(appData.positionId)!.salary = salary.text.toInt()!
        
        //We refresh committees informations
        appData.refreshCommittees()
        
        //We go back to positionsviewcontroller
        self.navigationController?.popViewControllerAnimated(true)
    }
}
