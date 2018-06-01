//
//  BaseModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/21.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let defaultUserName = "codingdoge"


/// 基础数据包括: 用户名、发布时间、头像地址、feed描述
class BaseModel: NSObject, ListDiffable {
    var userID: String
    
    var userName: String
    
    var userAvatarUrl: String
    
    var defaultAvatarImg: String
    
    override init() {
        userID = ""
        userName = ""
        userAvatarUrl = ""
        defaultAvatarImg = ""
    }
    
    // MARK: UI Data
    func userNameAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: userName, fontSize: size, color: UIColor.darkBlueColor())
    }
    
    // MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? BaseModel {
            return self == object
        }
        return false
    }
}
