//
//  BBSCommon.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/15.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import Kingfisher


// MARK: Tips
func AssertMainThread() {
    assert(Thread.current == Thread.main, "This method must be called on the main thread")
}

func AssertFail(_ message: String) {
    assert(false, message)
}



// MARK: NotificationKey
public let BBSTabBarHasBringToFrontNotification = "BBSTabBarHasBringToFrontNotification"



// MARK: PreMethods
public func StringToCGFloat(_ string: String) -> CGFloat {
    let ans = NSString(string: string)
    return CGFloat(ans.floatValue)
}



// MARK: Size
public let BBSScreenBounds = UIScreen.main.bounds

public let BBSScreenScale = UIScreen.main.scale

public let BBSScreenWidth = BBSScreenBounds.width

public let BBSScreenHeight = BBSScreenBounds.height

public let DeviceUUID = NSUUID().uuidString

public let IsIphone_X = UIDevice.current.isIphoneX

public let BBSCurrentSystemVersion: CGFloat = StringToCGFloat(UIDevice.current.systemVersion)

//public 

public let BBSWindows = UIApplication.shared.windows

public let BBSNavigationBarHeight: CGFloat = 44

public let BBSTabbarHeight: CGFloat = 49



// MARK: Color
public func UIColorFromRGB(_ rgbValue: NSInteger) -> UIColor {
    return UIColor.bbs_colorWith(hexValue: rgbValue)
}

public let AppTintColor = UIColorFromRGB(0xffffff)      // 导航栏颜色

public let AppTitleColor = UIColorFromRGB(0x222222)     // 导航栏标题颜色

public let BBSStatusBarColor = UIColorFromRGB(0x466676)



// MARK: Instance
public let BBSApplication = UIApplication.shared

let RootViewController = BBSRootViewController.shared



// MARK: Methods
public func showAlretWith(title: String, message: String, by self: UIViewController) -> Void {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        
    }))
    self.present(alert, animated: true, completion: nil)
}

func dispatch_queue_async_safe(queue: DispatchQueue, _ block: @escaping ()->()) {
    if Thread.current.name == queue.label {
        block()
    } else {
        queue.async {
            block()
        }
    }
}

func dispatch_main_async_safe(_ block: @escaping () -> ()) {
    dispatch_queue_async_safe(queue: DispatchQueue.main) {
        block()
    }
}
