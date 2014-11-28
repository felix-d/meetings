//
//  MeterViewController.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-28.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

class MeterViewController: UIViewController {

    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var cost: UILabel!
    var startTime = NSTimeInterval()
    var timerr = NSTimer()
    var mycost: Float = 0
    var currentBudget = 0
    
    @IBAction func stop(sender: AnyObject) {
        timerr.invalidate()
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        var time2 = elapsedTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes): "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds): "0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction): "0" + String(fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        var coststring: String = NSString(format:"%.2f", mycost * Float(time2))
        timer.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        cost.text = "\(coststring) $"
        
    }
    override func viewDidAppear(animated: Bool) {
        mycost = appData.getSalaryPerSecond()
        
        let aSelector : Selector = "updateTime"
        
        timerr = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        self.navigationController?.popViewControllerAnimated(true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        
    }

    

}
