//
//  UserModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class UserModel: BaseModel {
    
    var message: String
    
    var timeSincePost: String

    var title: String
    
    var comments: [CommentModel]
    
    var isUserLocalImage: Bool = false
    
    var localImage: UIImage? = nil
    
    override init() {
        message = ""
        timeSincePost = ""
        title = ""
        comments = []
    }
    
    init(withBaseModel model: BaseModel) {
        message = ""
        timeSincePost = ""
        title = ""
        comments = []
        super.init()
        userID = model.userID
        userName = model.userName
        userAvatarUrl = model.userAvatarUrl
        defaultAvatarImg = model.defaultAvatarImg
        
    }
}
