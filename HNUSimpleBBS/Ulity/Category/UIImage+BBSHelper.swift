//
//  UIImage+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIImage {
    func makeCircularImageWith(size: CGSize) -> UIImage {
        let circleRect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width/2)
        circle.addClip()
        draw(in: circleRect)
        guard let roundedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return roundedImage
    }
}
