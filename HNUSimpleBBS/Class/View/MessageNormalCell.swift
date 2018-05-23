//
//  MessageNormalCell.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentSpacing = 8

class MessageNormalCell: UICollectionViewCell {
    var avatarImg: UIImageView
    var timeSincePostLabel: UILabel
    var userNameLabel: UILabel
    var titleLabel: UILabel
    
    override init(frame: CGRect) {
        avatarImg = UIImageView()
        
        timeSincePostLabel = UILabel()
        timeSincePostLabel.text = "2018-05-12"
        timeSincePostLabel.font = UIFont.bbs_defaultFontWith(size: 12);
        timeSincePostLabel.textColor = .gray
        
        userNameLabel = UILabel()
        userNameLabel.text = "Dente"
        userNameLabel.font = UIFont.bbs_defaultFontWith(size: 12)
        userNameLabel.textColor = UIColorFromRGB(0xFFFFFF)
        
        titleLabel = UILabel()
        titleLabel.text = "你们开始找实习了没"
        titleLabel.font = UIFont.bbs_defaultFontWith(size: 15)
        titleLabel.textColor = UIColorFromRGB(0xFFFFFF)
        super.init(frame: frame)
        
        addSubview(avatarImg)
        avatarImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kComponentSpacing)
            make.bottom.equalTo(self).offset(kComponentSpacing)
            make.width.height.equalTo(30)
        }
        addSubview(timeSincePostLabel)
        timeSincePostLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImg.snp.right).offset(kComponentSpacing)
            make.bottom.equalTo(self).offset(kComponentSpacing)
            make.right.equalTo(self)
            make.height.equalTo(13)
        }
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImg).offset(kComponentSpacing)
            make.bottom.equalTo(timeSincePostLabel.snp.top).offset(-4)
            make.right.equalTo(self)
            make.height.equalTo(13)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kComponentSpacing)
            make.right.equalTo(self)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
