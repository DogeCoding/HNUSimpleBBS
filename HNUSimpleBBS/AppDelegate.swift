//
//  AppDelegate.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/7.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
//            statusBar.backgroundColor = UIColor.defaultYellow()
//        }
//        UIApplication.shared.statusBarStyle = .lightContent
//        window?.backgroundColor = UIColor.defaultYellow()
//        window = BBSWindowWithStatusBarUnderlay.init(frame: BBSScreenBounds)
//        window?.backgroundColor = .white
//        window?.makeKeyAndVisible()

        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the a
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

