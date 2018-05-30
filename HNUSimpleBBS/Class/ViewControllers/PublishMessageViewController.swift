//
//  PublishMessageViewController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kComponentPadding: CGFloat = 10

class PublishMessageViewController: UIViewController, UITextViewDelegate {
    
    var model: UserModel = UserModel()
    
    fileprivate var titleTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 15)
        view.contentInset = UIEdgeInsets(top: kComponentPadding, left: kComponentPadding, bottom: kComponentPadding, right: kComponentPadding)
        return view
    }()
    
    fileprivate var messageTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 15)
        view.contentInset = UIEdgeInsets(top: kComponentPadding, left: kComponentPadding, bottom: kComponentPadding, right: kComponentPadding)
        return view
    }()
    
    var titlePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "一句话说出你的故事名字..."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.contentMode = .top
        return label
    }()
    
    var messagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "请直抒你的胸臆..."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.contentMode = .top
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        let bar = BBSNavigationBar().setBottomLineStyle().place(at: self)
        bar.backgroundColor = .white
        bar.barItem.titleView = {
            let label = UILabel()
            label.text = "发表帖子"
            label.textColor = UIColorFromRGB(0x222222)
            label.font = UIFont.bbs_defaultFontWith(size: 18)
            label.sizeToFit()
            return label
        }()
        let rightBtn = UIButton()
        rightBtn.setTitle("发布", for: .normal)
        rightBtn.setTitleColor(UIColorFromRGB(0x222222), for: .normal)
        rightBtn.addTarget(self, action: #selector(handlePublish), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: rightBtn)
        bar.barItem.rightBarButtonItem = rightBarItem
        
        let contentView = UIView()
        contentView.backgroundColor = UIColorFromRGB(0xB1B2B1)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(bar.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        titleTextView.delegate = self
        contentView.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(kComponentPadding)
            make.left.equalTo(contentView).offset(kComponentPadding)
            make.right.equalTo(contentView).offset(-kComponentPadding)
            make.height.equalTo(50)
        }
        titleTextView.addSubview(titlePlaceholderLabel)
        titlePlaceholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleTextView).offset(3)
            make.right.equalTo(titleTextView)
            make.top.equalTo(titleTextView).offset(6)
            make.height.equalTo(20)
        }
        
        messageTextView.delegate = self
        contentView.addSubview(messageTextView)
        messageTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextView.snp.bottom).offset(kComponentPadding*2)
            make.left.right.equalTo(titleTextView)
            make.height.equalTo(200)
        }
        messageTextView.addSubview(messagePlaceholderLabel)
        messagePlaceholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(messageTextView).offset(3)
            make.right.equalTo(messageTextView)
            make.top.equalTo(messageTextView).offset(6)
            make.height.equalTo(20)
        }
        
        let topView = UIToolbar(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: 30))
        topView.barStyle = .default
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(dismissKeyBoard))
        topView.items = [btnSpace, doneButton]
        titleTextView.inputAccessoryView = topView
        messageTextView.inputAccessoryView = topView
        
    }
    
    @objc func handlePublish() {
        let messageModel = UserModel()
        let userInfo = LoginModuel.shared.userInfo
        messageModel.userID = userInfo.userID
        messageModel.userAvatarUrl = userInfo.userAvatarUrl
        messageModel.userName = userInfo.userName
        messageModel.title = titleTextView.text
        messageModel.message = messageTextView.text
        messageModel.timeSincePost = String.getCurrentTimeString()
        RootViewController.messageVC.viewModel.datas.insert(messageModel, at: 0)
        RootViewController.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func dismissKeyBoard() {
        titleTextView.resignFirstResponder()
        messageTextView.resignFirstResponder()
    }
    
    // MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTextView {
            if textView.text.count == 0 {
                titlePlaceholderLabel.isHidden = false
            } else {
                titlePlaceholderLabel.isHidden = true
            }
        } else {
            if textView.text.count == 0 {
                messagePlaceholderLabel.isHidden = false
            } else {
                messagePlaceholderLabel.isHidden = true
            }
        }
        
    }
    
}
