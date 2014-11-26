//
//  AppDelegate.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-22.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import UIKit

var appData = AppData()
var committeesViewController: UIViewController = UIViewController()
var positionsViewController: UIViewController = UIViewController()
var newCommitteeViewController: UIViewController = UIViewController()
var newPositionViewController: UIViewController = UIViewController()
var editPositionViewController: UIViewController = UIViewController()
var  editCommitteeViewController: UIViewController = UIViewController()
var firstViewController: UIViewController = UIViewController()

func containsPosition(array: [Position], pos: Position) -> Bool{
    for(var i = 0; i<array.count; i++){
        println(array[i].id)
        println(pos.id)
        if(array[i].id == pos.id){
            println("true")
            return true
        }
    }
    return false
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var pos1: Position = Position(name: "Boss", salary: 500000)
        var pos2: Position = Position(name: "Secretary", salary: 60000)
//        appData.addPosition(pos1)
//        appData.addPosition(pos2)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.BlackOpaque
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

