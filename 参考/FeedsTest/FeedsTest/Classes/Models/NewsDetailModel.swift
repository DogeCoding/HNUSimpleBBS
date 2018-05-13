//
//  NewsDetailModel.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class NewsDetailImage {
    
    var url: String?
    
    var width: Int?
    
    var height: Int?
    
    var rate: CGFloat = 1
    
    init(dict: [String: AnyObject]) {
        url = dict["url"] as? String
        height = dict["height"] as? Int
        width = dict["width"] as? Int
        rate = CGFloat(width!) / CGFloat(height!)
    }
}
