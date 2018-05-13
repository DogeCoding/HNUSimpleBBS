//
//  MilitaryNewsMorePicCellViewModel.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class MilitaryNewsMorePicCellViewModel {
    var title: String = ""
    var leftThumbImageUrl: String = ""
    var middleThumbImageUrl: String = ""
    var rightThumbImageUrl: String = ""
    var article_url:String?
    
    init() {
        
    }
    
    init(title: String, urls: [String], articleUrl: String?) {
        self.title = title
        if urls.count > 2 {
            leftThumbImageUrl = urls[0]
            middleThumbImageUrl = urls[1]
            rightThumbImageUrl = urls[2]
        }
        article_url = articleUrl
    }
}
