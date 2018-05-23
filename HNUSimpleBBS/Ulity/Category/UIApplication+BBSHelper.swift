//
//  UIApplication+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
