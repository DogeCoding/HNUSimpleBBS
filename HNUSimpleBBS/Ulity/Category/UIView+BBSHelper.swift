//
//  UIView+BBSSupport.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let ROLLING_INDICATOR_TAG = 231025
extension UIView {
    class func defaultNibView() -> UIView? {
        guard let array = Bundle.main.loadNibNamed(NSStringFromClass(self), owner: self, options: nil) as? [UIView] else {
            return nil
        }
        return array.first
    }
    
    func removeAllSubviews() {
        while subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
    func startRolling() {
        if let aiv = viewWithTag(ROLLING_INDICATOR_TAG) as? UIActivityIndicatorView {
            bringSubview(toFront: aiv)
            aiv.startAnimating()
            return
        }
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .white)
        aiv.tag = ROLLING_INDICATOR_TAG
        aiv.center = CGPoint(x: bounds.x/2, y: bounds.y/2)
        addSubview(aiv)
        bringSubview(toFront: aiv)
        aiv.startAnimating()
    }
    
    func endRolling() {
        if let aiv = viewWithTag(ROLLING_INDICATOR_TAG) as? UIActivityIndicatorView {
            aiv.stopAnimating()
            aiv.removeFromSuperview()
        }
        return
    }
    
//    class func show(tip: NSString, tag: NSInteger) -> 
}
