//
//  MessageCommentHeaderView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/29.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class MessageCommentHeaderView: UICollectionReusableView {
    var messageLabel: UILabel
    
    override init(frame: CGRect) {
        messageLabel = UILabel()
        messageLabel.text = "0条回帖"
        super.init(frame: frame)
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.centerY.equalTo(self)
        }
        let lineView = UIView()
        lineView.backgroundColor = UIColorFromRGB(0x333333)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1/BBSScreenScale)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
