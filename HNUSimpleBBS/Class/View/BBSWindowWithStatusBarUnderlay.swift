//
//  BBSWindowWithStatusBarUnderlay.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/16.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSWindowWithStatusBarUnderlay: UIWindow {
    let _statusBarOpaqueUnderlayView = UIView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _statusBarOpaqueUnderlayView.backgroundColor = BBSStatusBarColor
        addSubview(_statusBarOpaqueUnderlayView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubview(toFront: _statusBarOpaqueUnderlayView)
        
        let statusBarFrame = CGRect.zero
        statusBarFrame.size.width = BBSScreenWidth
        statusBarFrame.size.height = BBSApplication.statusBarFrame.size.height
        _statusBarOpaqueUnderlayView.frame = statusBarFrame
    }
}





