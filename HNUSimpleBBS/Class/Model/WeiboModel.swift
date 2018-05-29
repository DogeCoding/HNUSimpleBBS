//
//  WeiboModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class WeiboModel: BaseModel {
    var message: String
    
    var timeSincePost: String

    var totalNumbersOfImgs: NSInteger
    var imgUrls: [String]
    let dafaultImgPath: String
    
    override init() {
        message = "There are no new messages."
        timeSincePost = "2018-1-1"
        totalNumbersOfImgs = 3
        imgUrls = [defaultImgUrls[defaultImgRandom()], defaultImgUrls[defaultImgRandom()], defaultImgUrls[defaultImgRandom()]]
        dafaultImgPath = defaultWeiboImgPath
        super.init()
    }
    
    func messageAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: message, fontSize: size, color: UIColor.darkGray)
    }
    
    func timeSincePostAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: timeSincePost, fontSize: size, color: UIColor.lightGray)
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? WeiboModel else { return false }
        return self == object
    }
}
