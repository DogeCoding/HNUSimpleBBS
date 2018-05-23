//
//  WeiboModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class WeiboModel: BaseModel {
    
    var userID: NSInteger

    var totalNumbersOfImgs: NSInteger
    var imgUrls: [String]
    let dafaultImgPath: String
    
    override init() {
        userID = 0
        totalNumbersOfImgs = 3
        imgUrls = [defaultImgUrls[defaultImgRandom()], defaultImgUrls[defaultImgRandom()], defaultImgUrls[defaultImgRandom()]]
        dafaultImgPath = defaultWeiboImgPath
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? WeiboModel else { return false }
        return userID == object.userID
    }
}
