//
//  MessageDetailHeaderView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/25.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentPadding: CGFloat = 8
fileprivate let avatarImgHeight: CGFloat = 35
fileprivate let titleFontSize: CGFloat = 17
fileprivate let messageFontSize: CGFloat = 16

class MessageDetailHeaderView: UIScrollView {
    var data: UserModel {
        didSet {
            title.text = data.title
            userAvatar.kf.setImage(with: URL(string: data.userAvatarUrl))
            userName.text = data.userName
            timeSincePostLabel.text = data.timeSincePost
            message.text = data.message
            setNeedsLayout()
        }
    }
    
    var title: UITextView = {
        let title = UITextView()
        title.textAlignment = .left
        title.isEditable = false
        title.font = UIFont.bbs_defaultFontWith(size: titleFontSize)
        title.textColor = .black
        return title
    }()
    
    var userAvatar: UIImageView = {
        let userAvatar = UIImageView(image: UIImage(named: "icon_avatarImg"))
        userAvatar.layer.cornerRadius = avatarImgHeight/2
        userAvatar.layer.masksToBounds = true
        return userAvatar
    }()
    
    var userName: UILabel = {
        let userName = UILabel()
        userName.textAlignment = .left
        userName.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 14)
        userName.textColor = .black
        return userName
    }()
    
    var timeSincePostLabel: UILabel = {
        let timeSincePostLabel = UILabel()
        timeSincePostLabel.textAlignment = .left
        timeSincePostLabel.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 12)
        timeSincePostLabel.textColor = UIColorFromRGB(0x333333)
        return timeSincePostLabel
    }()
    
    var message: UITextView = {
        let message = UITextView()
        message.backgroundColor = .clear
        message.textAlignment = .left
        message.isEditable = false
        message.font = UIFont.systemFont(ofSize: messageFontSize)
        return message
    }()
    
    init() {
        data = UserModel()
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(title)
        title.setTop(kComponentPadding)
        title.setLeft(kComponentPadding)
        title.setWidth(BBSScreenWidth-kComponentPadding*2)
        title.setHeight(18)
        addSubview(userAvatar)
        userAvatar.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(kComponentPadding)
            make.left.equalTo(self).offset(kComponentPadding)
            make.width.height.equalTo(avatarImgHeight)
        }
        addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar)
            make.left.equalTo(userAvatar.snp.right).offset(kComponentPadding/2)
            make.height.equalTo(17)
            make.width.equalTo(200)
        }
        addSubview(timeSincePostLabel)
        let timeTopPadding = (avatarImgHeight-17-14) > 0 ? (avatarImgHeight-17-14) : 0
        timeSincePostLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(timeTopPadding)
            make.left.equalTo(userName)
            make.height.equalTo(14)
            make.right.equalTo(self)
        }
        addSubview(message)
        message.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(kComponentPadding)
            make.left.equalTo(self).offset(kComponentPadding)
            make.width.equalTo(BBSScreenWidth-kComponentPadding*2)
        }
        let lineView = UIView()
        lineView.backgroundColor = UIColorFromRGB(0x333333)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(BBSScreenWidth)
            make.height.equalTo(1/BBSScreenScale)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let messageHeight = ceil(message.sizeThatFits(CGSize(width: BBSScreenWidth - kComponentPadding*2, height: CGFloat(MAXFLOAT))).height)
        let titleHeight = ceil(title.sizeThatFits(CGSize(width: BBSScreenWidth - kComponentPadding*2, height: CGFloat(MAXFLOAT))).height)
        setHeight(kComponentPadding*4+avatarImgHeight+titleHeight+messageHeight)
        title.setHeight(titleHeight)
        message.snp.remakeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(kComponentPadding)
            make.left.equalTo(self).offset(kComponentPadding)
            make.width.equalTo(BBSScreenWidth-kComponentPadding*2)
            make.height.equalTo(messageHeight)
        }
        
    }
    
    class func calculateViewHeight(withData data: UserModel) -> CGFloat {
        let titleHeight = data.title.calculateTextHeight(withFont: UIFont.bbs_defaultFontWith(size: 17))
        let messageHeight = data.message.calculateTextHeight(withFont: UIFont.systemFont(ofSize: messageFontSize))
        return titleHeight + avatarImgHeight + messageHeight + kComponentPadding*3
    }
}
