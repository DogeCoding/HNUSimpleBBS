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
    
    override init() {
        message = "There are no new messages."
        timeSincePost = "2018-1-1"
        title = "今晚有一起去综合楼自习的吗"
        comments = []
    }
}
