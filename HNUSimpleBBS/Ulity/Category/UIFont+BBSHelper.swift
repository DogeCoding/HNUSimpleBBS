//
//  UIFont+Shortcut.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIFont {
    class func bbs_fontWith(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        if let font = font {
            return font;
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    class func bbs_defaultFontWith(size: CGFloat) -> UIFont {
        return UIFont.bbs_fontWith(name: "PingFangSC-Semibold", size: size)
    }
}
