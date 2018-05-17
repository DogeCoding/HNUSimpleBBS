//
//  AppDelegate.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/7.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: BBSWindowWithStatusBarUnderlay?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = BBSWindowWithStatusBarUnderlay.init(frame: BBSScreenBounds)
        window?.backgroundColor = .white
        
//        let rootVC = RootViewControlle.init()
        
        
        window?.makeKeyAndVisible()
        
//        window?.rootViewController = RootViewController()
        
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

