//
//  MilitaryNewsOnePicCell.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class MilitaryNewsOnePicCellViewModel {
    
    var title: String = ""
    var rightThumbImageUrl: String = ""
    var article_url: String?
    
    init(title: String, url: String, articleUrl: String?) {
        self.title = title
        rightThumbImageUrl = url
        article_url = articleUrl
    }
    
    init() {
        
    }
    
}
