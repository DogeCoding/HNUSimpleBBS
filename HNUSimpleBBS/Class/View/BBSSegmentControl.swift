//
//  BBSSegmentControl.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kBBSSegmentControlTitleTagBase = 100

class BBSSegmentControl: UIControl {
    
    var selectedIndex: NSInteger
    
    fileprivate var titles: Array<String> {
        didSet {
            removeAllSubviews()
            totleWidth = 0
            var index: NSInteger = 0
            for title in oldValue {
                let label = UILabel(frame: .zero)
                label.tag = kBBSSegmentControlTitleTagBase + index
                var font =
            }
        }
    }
    
    fileprivate var totleWidth: CGFloat
    
    func initWith(titles: Array<String>) {
        
    }
}
