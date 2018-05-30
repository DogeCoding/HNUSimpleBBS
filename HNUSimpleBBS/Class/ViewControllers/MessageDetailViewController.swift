//
//  MessageDetailViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/23.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let cellID = "MessageCommentCell"
fileprivate let headerID = "MessageCommentHeaderView"
fileprivate let footerID = "BBSMessageFooterView"

class MessageDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var model: UserModel = UserModel()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: BBSScreenWidth, height: 50)
        layout.itemSize = CGSize(width: BBSScreenWidth, height: 130)
        layout.minimumLineSpacing = 3
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var bar = BBSNavigationBar().setTransparentStyle()
    
    var headerView: MessageDetailHeaderView = MessageDetailHeaderView()
    
    var commentBtn: UIButton = {
        let btn = UIButton()
//        btn.setImage(UIImage(named: "icon_message_comment"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setTitle("回帖", for: .normal)
        btn.addTarget(self, action: #selector(clickCommentBtn), for: .touchUpInside)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppTintColor
        bar = bar.place(at: self)
        bar.backgroundColor = AppTintColor
        bar.barItem.titleView = {
            let label = UILabel()
            label.text = "BBS"
            label.textColor = UIColorFromRGB(0x222222)
            label.font = UIFont.bbs_defaultFontWith(size: 18)
            label.sizeToFit()
            return label
        }()

        model.message = "蝶恋花\n伫倚危楼风细细，望极春愁，黯黯生天际。\n草色烟光残照里，无言谁会凭阑意。\n拟把疏狂图一醉，对酒当歌，强乐还无味。\n衣带渐宽终不悔，为伊消得人憔悴。"
        headerView.data = model
        view.addSubview(headerView)
        headerView.setTop(20+BBSNavigationBarHeight)
        headerView.setLeft(0)
        headerView.setWidth(BBSScreenWidth)
        
        view.addSubview(commentBtn)
        commentBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(BBSTabbarHeight)
        }
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.delaysContentTouches = false
        collectionView.scrollsToTop = true
        
        collectionView.register(MessageCommentCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(MessageCommentHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(BBSMessageFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentBtn.snp.top)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    // MARK: Action
    @objc fileprivate func clickCommentBtn() {
        
        LoginModuel.shared.showLoginContinue { (userInfo) in
            let replyView = MessageReplyView()
            replyView.show()
            replyView.replySuccesClosure = { (message) in
                let commentData = CommentModel()
                commentData.userID = userInfo.userID
                commentData.userAvatarUrl = userInfo.userAvatarUrl
                commentData.userName = userInfo.userName
                
                commentData.commentPostTime = String.getCurrentTimeString()
                commentData.comment = message
                self.model.comments.append(commentData)
                self.collectionView.reloadData()
            }
        }
        
        
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MessageCommentCell else {
            return UICollectionViewCell()
        }
        cell.data = model.comments[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as? MessageCommentHeaderView else {
                return UICollectionReusableView()
            }
            headerView.messageLabel.text = "\(model.comments.count)条回帖"
            return headerView
        } else {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID, for: indexPath) as? BBSMessageFooterView else {
                return UICollectionReusableView()
            }
            footerView.updateTip(isHasData: model.comments.count > 0, isHasMore: false)
            if model.comments.count == 0 {
                footerView.tipLabel.text = "还没有人回复哦😯"
            }
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        iToast.makeText("☺️").show()
    }
    
    // MARK: UICollectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: BBSScreenWidth, height: 40)
//        if model.comments.count > 0 {
//            return CGSize(width: BBSScreenWidth, height: 40)
//        } else {
//            return .zero
//        }
    }
}
