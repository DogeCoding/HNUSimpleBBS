//
//  BaseModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/21.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let defaultUserName = "codingdoge"

class BaseModel: NSObject, ListDiffable {
    var userName: String
    
    var message: String
    
    var timeSincePost: String
    
    var userAvatarUrl: String
    
    let defaultAvatarImg: String
    
    override init() {
        userName = defaultUserName
        message = "There are no new messages."
        timeSincePost = "2018-1-1"
        userAvatarUrl = defaultAvatarUrls[defaultAvatarRandom()]
        defaultAvatarImg = defaultAvatarImgPath
    }
    
    // MARK: UI Data
    func userNameAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: userName, fontSize: size, color: UIColor.darkBlueColor())
    }
    
    func messageAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: message, fontSize: size, color: UIColor.darkGray)
    }
    
    func timeSincePostAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: timeSincePost, fontSize: size, color: UIColor.lightGray)
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
