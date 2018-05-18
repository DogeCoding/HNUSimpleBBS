//
//  WeiboViewModel.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class WeiboViewModel: BaseViewModel {
    var totalNumbersOfImgs: NSInteger
    var imgUrls: [String]
    var message: String
    
    override init() {
        let defaultHomeViewModelImgPath = "dafaultHomeViewModelImg"
        totalNumbersOfImgs = 3
        imgUrls = [defaultHomeViewModelImgPath, defaultHomeViewModelImgPath, defaultHomeViewModelImgPath]
        message = "There are no new messages."
    }
}
