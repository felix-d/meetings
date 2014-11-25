//
//  FirstViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-22.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var committeeName: UIButton!
    @IBOutlet weak var changeCommittee: UIButton!
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var meetingGoal: UITextField!
    
    @IBAction func startMeeting(sender: UIButton) {
        
    }
    @IBAction func editCommittee(sender: UIButton) {
        if(appData.positions.count == 0) {
            self.navigationController?.pushViewController(newCommitteeViewController, animated: true)
        } else if (appData.committees.count == 0) {
            self.navigationController?.pushViewController(newCommitteeViewController, animated: true)
            
        } else {
            appData.committeeIndex = appData.currentCommittee
            self.navigationController?.pushViewController(editCommitteeViewController, animated: true)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        editCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("editcommittee") as UIViewController
        newCommitteeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newcommittee") as UIViewController
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        appData.tempParticipants = []
        appData.tempCommitteeName = ""
        appData.startedEditingCommittee = false
        
        if appData.positions.count == 0 {
             committeeName.setTitle("Start adding positions!", forState: UIControlState.Normal)
            changeCommittee.hidden = true
        }
        else if appData.committees.count == 0 {
            committeeName.setTitle("Add a committee!", forState: UIControlState.Normal)
            changeCommittee.hidden = true
        }
        else {
            committeeName.setTitle(appData.committees[appData.currentCommittee].name, forState: UIControlState.Normal)
            
            if appData.committees.count > 1 {
                changeCommittee.hidden = false
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

