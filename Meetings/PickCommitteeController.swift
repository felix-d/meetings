//
//  PickCommitteeController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-27.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class PickCommitteeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var committeePicker: UIPickerView!
    var pickerCommittee: [Committee] = []
    
    @IBAction func backToHomeScreen(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        gestureRecognizer.delegate = self
        //We set the right picker to be used
        committeePicker.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        //get committees except current one
        pickerCommittee = appData.getCommitteesExceptCurrent()

    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //Return data
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerCommittee[row].name
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCommittee.count
    }
    
    
    func gestureRecognizer(gestureRecognizer: UITapGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UITapGestureRecognizer) -> Bool {
        return true
    }
    
    
    //On tap on current picker position
    func tapped(recognizer: UITapGestureRecognizer){
        println("tapped")
        //if picker is empty
        if(pickerCommittee.count==0){
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        //get id of current selected picker
        appData.committeeId = pickerCommittee[committeePicker.selectedRowInComponent(0)].id
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}
