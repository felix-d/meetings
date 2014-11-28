
//
//  PickerParticipantController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class PickerParticipantController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
   
    
    @IBOutlet weak var myPicker: UIPickerView!
   
    
    var currentPicker = UIPickerView()
    
    //On tap on current picker position
    func tapped(recognizer: UITapGestureRecognizer){
        
        //if picker is empty
        if(appData.pickerPositions.count==0){
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        //get id of current selected picker
        var id = appData.pickerPositions[currentPicker.selectedRowInComponent(0)].id
       
        appData.tempParticipants.append(appData.getPosition(id)!)
        appData.tempParticipants.sort({$0.name < $1.name })
        appData.pickerPositions.removeAtIndex(currentPicker.selectedRowInComponent(0))
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    override func viewDidLoad() {
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        gestureRecognizer.delegate = self
        //We set the right picker to be used
        currentPicker = myPicker
        currentPicker.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //We reload picker data
       currentPicker.reloadAllComponents()
        
        if(appData.pickerPositions.count == 0){
            self.currentPicker.hidden = true
        } else {
            self.currentPicker.hidden = false
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UITapGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UITapGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
       
       

    }
    @IBAction func goBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)    }
    
    

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appData.pickerPositions.count
    }
    
    //Return data
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(row<appData.pickerPositions.count){
        return appData.pickerPositions[row].name
        }
        else{
         return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        appData.tempParticipants.append(Position(name: appData.pickerPositions[row].name, salary: appData.pickerPositions[row].salary))
//        appData.pickerPositions.removeAtIndex(row)
//        self.dismissViewControllerAnimated(true, completion: nil) 
        
    }

}
