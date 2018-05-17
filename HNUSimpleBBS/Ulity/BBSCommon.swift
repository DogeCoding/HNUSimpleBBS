//
//  BBSMacro.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/15.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import Kingfisher

// MARK: NotificationKey
public let BBSTabBarHasBringToFrontNotification = "BBSTabBarHasBringToFrontNotification"

// MARK: PreMethods
public func StringToCGFloat(_ string: String) -> CGFloat {
    guard let ans = Float(string) else {
        return -1
    }
    return CGFloat(ans)
}

// MARK: Size
public let BBSScreenBounds = UIScreen.main.bounds
public let BBSScreenScale = UIScreen.main.scale
public let BBSScreenWidth = BBSScreenBounds.width
public let BBSScreenHeight = BBSScreenBounds.height
public let BBSCurrentSystemVersion: CGFloat = StringToCGFloat(UIDevice.current.systemVersion)
public let BBSKeyWindow = UIApplication.shared.keyWindow

public let BBSTabbarHeight: CGFloat = 49

// MARK: Color
public func UIColorFromRGB(_ rgbValue: NSInteger) -> UIColor {
    return UIColor.bbs_colorWith(hexValue: rgbValue)
}
public let AppTintColor = UIColorFromRGB(0xffffff)

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
