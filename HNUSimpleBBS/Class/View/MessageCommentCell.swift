//
//  MessageCommentCell.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/29.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentPadding: CGFloat = 8
fileprivate let avatarImgHeight: CGFloat = 35
fileprivate let titleFontSize: CGFloat = 17
fileprivate let commentFontSize: CGFloat = 16

class MessageCommentCell: UICollectionViewCell {
    var avatarImg: UIImageView
    var timeSincePostLabel: UILabel
    var userNameLabel: UILabel
    var commentText: UITextView
    var indicateLine: UIView
    
    var data: CommentModel {
        didSet {
            avatarImg.kf.setImage(with: URL(string: data.userAvatarUrl))
            timeSincePostLabel.text = data.commentPostTime
            userNameLabel.text = data.userName
            commentText.text = data.comment
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        avatarImg = UIImageView()
        avatarImg.layer.masksToBounds = true
        avatarImg.layer.cornerRadius = avatarImgHeight/2
        avatarImg.contentScaleFactor = BBSScreenScale
        avatarImg.contentMode = .scaleAspectFill
        //        avatarImg.isUserInteractionEnabled = false
        
        timeSincePostLabel = UILabel()
        timeSincePostLabel.textAlignment = .left
        timeSincePostLabel.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 12)
        timeSincePostLabel.textColor = UIColorFromRGB(0x333333)
        
        userNameLabel = UILabel()
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 14)
        userNameLabel.textColor = .black
        
        commentText = UITextView()
        commentText.backgroundColor = .clear
        commentText.textAlignment = .left
        commentText.isEditable = false
        commentText.font = UIFont.systemFont(ofSize: commentFontSize)
        commentText.textColor = .black
        
        indicateLine = UIView()
        indicateLine.backgroundColor = UIColorFromRGB(0x333333)
        
        data = CommentModel()
        
        super.init(frame: frame)
        
        addSubview(avatarImg)
        avatarImg.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kComponentPadding)
            make.left.equalTo(self).offset(kComponentPadding)
            make.width.height.equalTo(avatarImgHeight)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImg)
            make.left.equalTo(avatarImg.snp.right).offset(kComponentPadding/2)
            make.height.equalTo(17)
            make.width.equalTo(200)
        }
        
        addSubview(timeSincePostLabel)
        let timeTopPadding = (avatarImgHeight-17-14) > 0 ? (avatarImgHeight-17-14) : 0
        timeSincePostLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(timeTopPadding)
            make.left.equalTo(userNameLabel)
            make.height.equalTo(14)
            make.right.equalTo(self)
        }
        
        addSubview(commentText)
        commentText.snp.makeConstraints { (make) in
            make.top.equalTo(timeSincePostLabel.snp.bottom).offset(kComponentPadding)
            make.left.equalTo(timeSincePostLabel)
            make.right.equalTo(self).offset(-kComponentPadding)
            make.bottom.equalTo(self).offset(-1/BBSScreenScale)
        }
        
        addSubview(indicateLine)
        indicateLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(1/BBSScreenScale)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
