//
//  AppDelegate.swift
//  Window
//
//  Created by Dana Majid on 15/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    var dragable : Bool = true
    var firstTime : Bool = true
    var showStatusbar : Bool = true
    var animator: ZFModalTransitionAnimator?
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        navigationController = UINavigationController()
        let mainViewController: CollectionViewController = CollectionViewController()
        //let mainViewController: MainViewController = MainViewController()
        
        navigationController!.viewControllers = [mainViewController]

        self.window!.rootViewController = navigationController
        
        self.window!.backgroundColor = UIColor.blackColor()
        self.window?.makeKeyAndVisible();
        self.window!.tintColor = UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openSection:", name: "openSection", object: nil)

        
        return true
    }
    
    func openSection(notification:NSNotification) {
        let tappedSection = (notification.object as! WrappedStruct<SectionItem>).getValue()
        
        let modalVC: SectionDetailViewController = SectionDetailViewController(tappedSection: tappedSection)
        let navController = UINavigationController(rootViewController: modalVC)
        navController.modalPresentationStyle = .Custom;
        
        self.animator = ZFModalTransitionAnimator(modalViewController: modalVC)
        self.animator!.dragable = true
        self.animator!.bounces = false
        self.animator!.behindViewAlpha = 0.6;
        self.animator!.behindViewScale = 0.88;
        self.animator!.transitionDuration = 0.6;
        self.animator!.direction = .Bottom
        
        navController.transitioningDelegate = self.animator;
        navigationController!.presentViewController(navController, animated: true, completion: nil)
        
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

