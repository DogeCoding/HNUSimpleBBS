//
//  MessageReplyView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/30.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let viewHeight: CGFloat = BBSNavigationBarHeight+BBSScreenHeight/2
fileprivate let kComponentPadding: CGFloat = 10

class MessageReplyView: UIView, UITextViewDelegate {
    var replySuccesClosure: ((_ message: String) -> ())? = nil
    
    fileprivate var headerBar: UIView = UIView()
    
    fileprivate var replyView: UITextView = {
        let replyView = UITextView()
        replyView.font = UIFont.systemFont(ofSize: 17)
        replyView.contentInset = UIEdgeInsets(top: kComponentPadding, left: kComponentPadding, bottom: kComponentPadding, right: kComponentPadding)
        return replyView
    }()
    
    var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "请直抒你的胸臆..."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.contentMode = .top
        return label
    }()
    
    init() {
        let kframe = CGRect(x: 0, y: BBSScreenHeight, width: BBSScreenWidth, height: BBSNavigationBarHeight+BBSScreenHeight/2)
        super.init(frame: kframe)
        frame = kframe
        
        backgroundColor = AppTintColor
        
        let cancleBtn = UIButton()
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(.black, for: .normal)
        cancleBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        cancleBtn.frame = CGRect(x: kComponentPadding, y: 0, width: 70, height: BBSNavigationBarHeight)
        headerBar.addSubview(cancleBtn)
        
        let pushBtn = UIButton()
        pushBtn.setTitle("提交", for: .normal)
        pushBtn.setTitleColor(.black, for: .normal)
        pushBtn.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        pushBtn.frame = CGRect(x: BBSScreenWidth-70-kComponentPadding, y: 0, width: 70, height: BBSNavigationBarHeight)
        headerBar.addSubview(pushBtn)
        
        addSubview(headerBar)
        headerBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(BBSNavigationBarHeight)
        }
        
        replyView.delegate = self
        addSubview(replyView)
        replyView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(headerBar.snp.bottom)
            make.height.equalTo(viewHeight-BBSNavigationBarHeight)
        }
        replyView.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(replyView).offset(kComponentPadding-2)
            make.right.equalTo(replyView).offset(-kComponentPadding)
            make.top.equalTo(replyView).offset(kComponentPadding)
            make.height.equalTo(19)
        }
        
        let topView = UIToolbar(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: 30))
        topView.barStyle = .default
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(dismissKeyBoard))
        topView.items = [btnSpace, doneButton]
        replyView.inputAccessoryView = topView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard let window = BBSWindows.first else { return }
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.setTop(BBSScreenHeight-viewHeight)
        }) { (finished) in
            self.replyView.becomeFirstResponder()
        }
    }
    
    @objc fileprivate func pushAction() {
        close()
        if let message = replyView.text {
            iToast.makeText("评论成功哟~").show()
            replySuccesClosure?(message)
        } else {
            iToast.makeText("评论失败啦😑").show()
            replySuccesClosure?("...该用户p都没说")
        }
    }
    
    @objc func close() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        replyView.resignFirstResponder()
        UIView.animate(withDuration: 0.4, animations: {
            self.setTop(BBSScreenHeight)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func dismissKeyBoard() {
        replyView.resignFirstResponder()
    }
    
    // MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 0 {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
