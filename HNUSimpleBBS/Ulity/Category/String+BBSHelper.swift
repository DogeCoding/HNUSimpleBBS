//
//  String+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/25.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension String {
    func calculateTextWidth(withFont font: UIFont, heigth: CGFloat = 15) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: heigth), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        return ceil(rect.width)
    }
    
    func calculateTextHeight(withFont font: UIFont, width: CGFloat = 300) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font : font], context: nil)
        return ceil(rect.height)
    }
    
    func calculateTextHeight(withFont font: UIFont, width: CGFloat = 300, maxHeight: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        return ceil(rect.height) > maxHeight ? maxHeight : ceil(rect.height)
    }
    
    static func getCurrentTimeString() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: now)
    }
}
