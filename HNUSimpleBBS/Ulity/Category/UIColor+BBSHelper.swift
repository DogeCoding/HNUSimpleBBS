//
//  UIColor+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIColor {
    
    class func darkBlueColor() -> UIColor {
        return UIColor(red: 70.0/255.0, green: 102.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    }
    
    class func lightBlueColor() -> UIColor {
        return UIColor(red: 70.0/255.0, green: 165.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    }
    
    class func bbs_redColorFrom(hexRGBColor color: NSInteger) -> CGFloat {
        return (CGFloat((color & 0xff0000) >> 16) / 255.0)
    }
    
    class func bbs_greenColorFrom(hexRGBColor color: NSInteger) -> CGFloat {
        return (CGFloat((color & 0x00ff00) >> 8) / 255.0)
    }
    
    class func bbs_blueColorFrom(hexRGBColor color: NSInteger) -> CGFloat {
        return (CGFloat(color & 0x0000ff) / 255.0)
    }
    
    class func bbs_colorWith(hexValue value: NSInteger) -> UIColor {
        return UIColor.bbs_colorWith(hexValue: value, alpha: 1)
    }
    
    class func bbs_colorWith(hexValue value: NSInteger, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: UIColor.bbs_redColorFrom(hexRGBColor: value),
                            green: UIColor.bbs_greenColorFrom(hexRGBColor: value),
                            blue: UIColor.bbs_blueColorFrom(hexRGBColor: value),
                            alpha: alpha)
    }
    
    class func bbs_randomColorWith(alpha: CGFloat) -> UIColor {
        return UIColor.init(hue: CGFloat(arc4random() % 256 / 256),
                            saturation: CGFloat(arc4random() % 128 / 256) + 0.5,
                            brightness: CGFloat(arc4random() % 128 / 256) + 0.5,
                            alpha: alpha)
    }
    
    class func bbs_randomColor() -> UIColor {
        return UIColor.bbs_randomColorWith(alpha: 1)
    }
}
