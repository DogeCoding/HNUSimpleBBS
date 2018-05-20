//
//  NSAttributedString+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension NSAttributedString {
    class func attributedStringWith(string: String,
                                    fontSize size: CGFloat,
                                    color: UIColor,
                                    _ firstWordColor: UIColor = .clear) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let attributes = [NSAttributedStringKey.foregroundColor : color,
                          NSAttributedStringKey.font : UIFont.bbs_defaultFontWith(size: size)]
        attributedString.addAttributes(attributes, range: NSMakeRange(0, string.count))
        
//        let firstSpaceRange = string.rangeOfCharacter(from: CharacterSet.whitespaces)
//        if let range = firstSpaceRange?.upperBound {
//            let firstWordRange = NSMakeRange(0, range)
//        }
        
        return attributedString
        
    }
}
