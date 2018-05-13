//
//  TestView.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class TestView: UIView {
    var redColorView: UIImageView
    
    override init(frame: CGRect) {
        redColorView = UIImageView()
        super.init(frame: frame)
        addSubview(redColorView)
        redColorView.backgroundColor = .clear
        redColorView.snp.makeConstraints{ (make) -> Void in
            make.center.equalToSuperview()
            make.width.height.equalTo(400)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
