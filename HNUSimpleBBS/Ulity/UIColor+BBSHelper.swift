//
//  UIColor+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIColor {
    class func bbs_redColorFrom(hexRGBColor color: NSInteger) -> Float {
        return (Float((color & 0xff0000) >> 16) / 255.0)
    }
    
    class func bbs_colorWith(hexValue value: NSInteger, alpha: Float) -> UIColor {
        return UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
}
