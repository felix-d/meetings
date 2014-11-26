//
//  FirstViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-22.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var committeeName: UIButton!
    @IBOutlet weak var changeCommittee: UIButton!
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var meetingGoal: UITextField!
    @IBOutlet weak var startMeeting: UIButton!
    
    var test = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We set nav bar buttons to white
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //We set background color to light grey
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        //We set Start Meeting button color to light blue
        startMeeting.setTitleColor(UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), forState: UIControlState.Normal)
        
        //View controllers initialization from storyboard
        editCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editcommittee") as UIViewController
        newCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newcommittee") as UIViewController
        positionsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("positions") as UIViewController
        newPositionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newposition") as UIViewController
        
    }
    
    //START MEETING
    @IBAction func startMeeting(sender: UIButton) {
        
    }
    
    //When committee name is tapped
    @IBAction func editCommittee(sender: UIButton) {
        
        //If there are no salary levels
        if(appData.positions.count == 0) {
            
            //We push 2 views to add salary levels on the nav stack
            self.navigationController?.pushViewController(positionsViewController, animated: true)
            self.navigationController?.pushViewController(newPositionViewController, animated: true)
            
        }
            
        //If there are salary levels but no committees
        else if (appData.committees.count == 0) {
            
            //We push new committee controller on nav stack
            self.navigationController?.pushViewController(newCommitteeViewController, animated: true)
            
            
        }
            
        //Else we edit current committee
        else {
            
            appData.committeeIndex = appData.currentCommittee
            self.navigationController?.pushViewController(editCommitteeViewController, animated: true)
        }
        
    }

  
    
    func changeBackButtonTitle(s: String){
        self.navigationItem.backBarButtonItem?.title = s
    }
    
    override func viewWillAppear(animated: Bool) {
        
        appData.tempParticipants = []
        appData.tempCommitteeName = ""
        appData.startedEditingCommittee = false
        
               
        if appData.positions.count == 0 {
            committeeName.setTitle("1. Tap to add salary levels", forState: UIControlState.Normal)
            if(test) { self.navigationItem.backBarButtonItem?.title = " " }
            self.navigationItem.rightBarButtonItem?.enabled = false
            committeeName.setTitleColor(UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), forState: UIControlState.Normal)
            changeCommittee.enabled = false
            budget.enabled = false
            meetingGoal.enabled = false
            startMeeting.enabled = false
            startMeeting.setTitleColor(UIColor(red: 122.0/255.0, green: 122.0/255.0, blue: 122.0/255, alpha: 0.2), forState: UIControlState.Normal)
        }
        else if appData.committees.count == 0 {
            self.navigationItem.backBarButtonItem?.title = "Cancel"
            committeeName.setTitle("2. Tap to create a committee", forState: UIControlState.Normal)
            self.navigationItem.rightBarButtonItem?.enabled = true
            committeeName.setTitleColor(UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), forState: UIControlState.Normal)
            changeCommittee.enabled = false
            budget.enabled = false
            meetingGoal.enabled = false
            startMeeting.enabled = false
            startMeeting.setTitleColor(UIColor(red: 122.0/255.0, green: 122.0/255.0, blue: 122.0/255, alpha: 0.2), forState: UIControlState.Normal)

        }
        else {

            self.navigationItem.backBarButtonItem?.title = ""
            committeeName.setTitle(appData.committees[appData.currentCommittee].name, forState: UIControlState.Normal)
             self.navigationItem.rightBarButtonItem?.enabled = true
            committeeName.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
            budget.enabled = true
            meetingGoal.enabled = true
            startMeeting.setTitleColor(UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), forState: UIControlState.Normal)

            if appData.committees.count > 1 {
                changeCommittee.hidden = false
            }
            
        }

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}

