//
//  UIView+Coordinate.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIView {
    func left() -> CGFloat {
        return frame.origin.x
    }
    
    func setLeft(_ x: CGFloat) {
        var tFrame = frame
        tFrame.origin.x = x
        frame = tFrame
    }
    
    func top() -> CGFloat {
        return frame.origin.y
    }
    
    func setTop(_ y: CGFloat) {
        var tFrame = frame
        tFrame.origin.y = y
        frame = tFrame
    }
    
    func right() -> CGFloat {
        return frame.origin.x + frame.size.width;
    }
    
    func setRight(_ right: CGFloat) {
        var tFrame = frame
        tFrame.origin.x = right - frame.size.width
        frame = tFrame
    }
    
    func bottom() -> CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    func setBottom(_ bottom: CGFloat) {
        var tFrame = frame
        tFrame.origin.y = bottom - frame.size.height
        frame = tFrame
    }
    
    func centerX() -> CGFloat {
        return center.x
    }
    
    func setCenterX(_ centerX: CGFloat) {
        center = CGPoint.init(x: centerX, y: center.y)
    }
    
    func centerY() -> CGFloat {
        return center.y
    }
    
    func setCenterY(_ centerY: CGFloat) {
        center = CGPoint.init(x: center.x, y: centerY)
    }
    
    func width() -> CGFloat {
        return frame.size.width
    }
    
    func setWidth(_ width: CGFloat) {
        var tFrame = frame
        tFrame.size.width = width
        frame = tFrame
    }
    
    func height() -> CGFloat {
        return frame.size.height
    }
    
    func setHeight(_ height: CGFloat) {
        var tFrame = frame
        tFrame.size.height = height
        frame = tFrame
    }
    
//    func screenViewX() -> CGFloat {
//        var x: CGFloat = 0
//
//    }
    
    func origin() -> CGPoint {
        return frame.origin
    }
    
    func setOrigin(_ origin: CGPoint) {
        var tFrame = frame
        tFrame.origin = origin
        frame = tFrame
    }
    
    func size() -> CGSize {
        return frame.size
    }
    
    func setSize(_ size: CGSize) {
        var tFrame = frame
        tFrame.size = size
        frame = tFrame
    }
}








