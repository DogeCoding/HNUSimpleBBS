//
//  CommentModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class CommentModel: BaseModel {
    var comment: String = "hello"
    var commentPostTime: String = "2018-5-12"
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? CommentModel else { return false }
        return commentPostTime == object.commentPostTime
    }
}
