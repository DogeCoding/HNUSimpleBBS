//
//  MessageDetailHeaderView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/25.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentPadding: CGFloat = 8
fileprivate let avatarImgHeight: CGFloat = 30
fileprivate let titleFontSize: CGFloat = 17
fileprivate let messageFontSize: CGFloat = 14

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
    
    var title: UILabel
    
    var userAvatar: UIImageView
    
    var userName: UILabel
    
    var timeSincePostLabel: UILabel
    
    var message: UITextView
    
    override init(frame: CGRect) {
        data = UserModel()
        
        title = UILabel()
        title.text = "自习了解下?"
        title.font = UIFont.bbs_defaultFontWith(size: titleFontSize)
        title.textColor = .black
        let titleHeight = title.text!.calculateTextHeight(withFont: title.font)
        
        userAvatar = UIImageView(image: UIImage(named: "icon_avatarImg"))
        
        userName = UILabel()
        userName.text = "codingdoge"
        userName.textAlignment = .left
        userName.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 14)
        userName.textColor = .black
        
        timeSincePostLabel = UILabel()
        timeSincePostLabel.text = "2018-5-1"
        timeSincePostLabel.textAlignment = .left
        timeSincePostLabel.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 12)
        timeSincePostLabel.textColor = UIColorFromRGB(0x333333)
        
        message = UITextView()
        message.text = "综合楼242\n自习\n👌？\n"
        message.textAlignment = .left
        message.isEditable = false
        message.font = UIFont.systemFont(ofSize: messageFontSize)
        let messageHeight = message.text.calculateTextHeight(withFont: message.font!)
        
        super.init(frame: frame)
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kComponentPadding)
            make.left.equalTo(self).offset(kComponentPadding)
            make.right.equalTo(self).offset(-kComponentPadding)
            make.height.equalTo(titleHeight)
        }
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
            make.height.equalTo(15)
            make.width.equalTo(200)
        }
        addSubview(timeSincePostLabel)
        let timeTopPadding = (avatarImgHeight-15-13) > 0 ? (avatarImgHeight-15-13) : 0
        timeSincePostLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(timeTopPadding)
            make.left.equalTo(userName)
            make.height.equalTo(13)
            make.right.equalTo(self)
        }
        addSubview(message)
        message.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(kComponentPadding)
            make.left.right.equalTo(self)
            make.height.equalTo(messageHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let messageHeight = message.text.calculateTextHeight(withFont: message.font!)
        message.snp.remakeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(kComponentPadding)
            make.left.right.equalTo(self)
            make.height.equalTo(messageHeight)
        }
    }
    
    class func calculateViewHeight(withData data: UserModel) -> CGFloat {
        let titleHeight = data.title.calculateTextHeight(withFont: UIFont.bbs_defaultFontWith(size: 17))
        let messageHeight = data.message.calculateTextHeight(withFont: UIFont.systemFont(ofSize: messageFontSize))
        return titleHeight + avatarImgHeight + messageHeight + kComponentPadding*3
    }
}
