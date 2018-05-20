//
//  WeiboViewModel.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//


fileprivate let defaultWeiboAvatarUrl = ""
fileprivate let defaultWeiboAvatarImg = "defaultWeiboAvatarImg"
fileprivate let defaultWeiboImgUrl = ""
fileprivate let defaultWeiboImgPath = "defaultWeiboImgPath"


class WeiboViewModel: BaseViewModel {
    var userAvatarUrl: String
    let defaultAvatarImg: String
    
    var totalNumbersOfImgs: NSInteger
    var imgUrls: [String]
    let dafaultImgPath: String
    
    override init() {
        userAvatarUrl = defaultWeiboAvatarUrl
        defaultAvatarImg = defaultWeiboImgUrl
        totalNumbersOfImgs = 3
        imgUrls = [defaultWeiboImgPath, defaultWeiboImgPath, defaultWeiboImgPath]
        dafaultImgPath = defaultWeiboImgPath
        super.init()
    }
}
