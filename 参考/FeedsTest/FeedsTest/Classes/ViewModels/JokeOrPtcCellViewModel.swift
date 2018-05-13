//
//  JokeOrPtcCellViewModel.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class JokeOrPctCellViewModel {
    var content: String?
    var large_image_url: String?
    var isJoke: Bool?
    
    init(content: String?, largeImageUrl: String?, isJoke: Bool?) {
        self.content = content
        self.large_image_url = largeImageUrl
        self.isJoke = isJoke
    }
}
