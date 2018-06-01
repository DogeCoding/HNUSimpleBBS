//
//  CommentModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class CommentModel: BaseModel {
    var comment: String = ""
    var commentPostTime: String = ""
    var isUserLocalImage: Bool = false
    var localImage: UIImage? = nil
    
    override init() {
        
    }
    
    init(withBaseModel model: BaseModel) {
        super.init()
        userID = model.userID
        userName = model.userName
        userAvatarUrl = model.userAvatarUrl
        defaultAvatarImg = model.defaultAvatarImg
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? CommentModel else { return false }
        return commentPostTime == object.commentPostTime
    }
}
