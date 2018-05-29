//
//  MessageNormalCell.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/22.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentSpacing: CGFloat = 8
fileprivate let avatarHeight: CGFloat = 50

class MessageNormalCell: UICollectionViewCell {
    var avatarImg: UIImageView
    var timeSincePostLabel: UILabel
    var userNameLabel: UILabel
    var titleLabel: UILabel
    var indicateLine: UIView
    
    var data: UserModel {
        didSet {
            avatarImg.kf.setImage(with: URL(string: data.userAvatarUrl))
            timeSincePostLabel.text = data.timeSincePost
            userNameLabel.text = data.userName
            titleLabel.text = data.title
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        avatarImg = UIImageView()
        avatarImg.layer.masksToBounds = true
        avatarImg.layer.cornerRadius = avatarHeight/2
        avatarImg.sizeToFit()
//        avatarImg.isUserInteractionEnabled = false
        
        timeSincePostLabel = UILabel()
        timeSincePostLabel.text = "2018-05-12"
        timeSincePostLabel.font = UIFont.bbs_defaultFontWith(size: 15);
        timeSincePostLabel.textColor = .gray
        
        userNameLabel = UILabel()
        userNameLabel.text = "Dente"
        userNameLabel.font = UIFont.bbs_defaultFontWith(size: 15)
        userNameLabel.textColor = UIColorFromRGB(0x222222)
        
        titleLabel = UILabel()
        titleLabel.text = "你们开始找实习了没"
        titleLabel.font = UIFont.bbs_defaultFontWith(size: 18)
        titleLabel.textColor = UIColorFromRGB(0x222222)
        
        indicateLine = UIView()
        indicateLine.backgroundColor = UIColorFromRGB(0x222222)
        
        data = UserModel()
        super.init(frame: frame)
        
        addSubview(avatarImg)
        avatarImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kComponentSpacing)
            make.bottom.equalTo(self).offset(-kComponentSpacing)
            make.width.height.equalTo(avatarHeight)
        }
        addSubview(indicateLine)
        indicateLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.width.equalTo(self).offset(-20)
            make.centerX.equalTo(self)
            make.height.equalTo(1/BBSScreenScale)
        }
        addSubview(timeSincePostLabel)
        timeSincePostLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImg.snp.right).offset(kComponentSpacing)
            make.bottom.equalTo(indicateLine.snp.top).offset(-kComponentSpacing)
            make.right.equalTo(self)
            make.height.equalTo(16)
        }
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImg.snp.right).offset(kComponentSpacing)
            make.bottom.equalTo(timeSincePostLabel.snp.top).offset(-(avatarHeight-16*2))
            make.right.equalTo(self)
            make.height.equalTo(16)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kComponentSpacing)
            make.right.equalTo(self)
            make.height.equalTo(19)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
