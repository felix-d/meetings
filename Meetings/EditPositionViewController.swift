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
        positionName.text = appData.positions[appData.positionIndex].name
        salary.text = String(appData.positions[appData.positionIndex].salary)
    }
    @IBAction func Editposition(sender: AnyObject) {
        appData.positions[appData.positionIndex].name = positionName.text
        appData.positions[appData.positionIndex].salary = salary.text.toInt()!
        appData.refreshCommittees()
        self.navigationController?.popViewControllerAnimated(true)
    }
}
