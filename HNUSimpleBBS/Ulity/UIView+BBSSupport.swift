//
//  UIView+BBSSupport.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIView {
    class func defaultNibView() -> UIView? {
        guard let array = Bundle.main.loadNibNamed(NSStringFromClass(self), owner: self, options: nil) as? [UIView] else {
            return nil
        }
        return array.first
    }
    
//    class func show(tip: NSString, tag: NSInteger) -> 
}
