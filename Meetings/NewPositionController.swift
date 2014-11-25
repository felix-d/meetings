//
//  NewPositionController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class NewPositionController: UIViewController, UITextFieldDelegate {
    
  
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var newPosition: UITextField!

    @IBOutlet weak var salary: UITextField!
    
    override func viewDidLoad() {
        self.newPosition.delegate = self
        self.salary.delegate = self
    }
    


    @IBAction func addPosition(sender: UIButton) {
        var position = Position(name: newPosition.text, salary: salary.text.toInt()!)
        appData.addPosition(position)
        newPosition.text = ""
        salary.text = ""
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
}
