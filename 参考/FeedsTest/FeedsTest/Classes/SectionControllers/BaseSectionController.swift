//
//  BaseSectionController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

// sectionController的基本代理
protocol BaseSectionControllerDelegate: class {
    func didSelect(data: Any)
}
