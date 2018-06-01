//
//  MineNameInputView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/31.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let viewHeight: CGFloat = BBSNavigationBarHeight+BBSScreenHeight/2
fileprivate let kComponentPadding: CGFloat = 10

class MineNameInputView: UIView {
    var nameChangeSuccesClosure: ((_ name: String) -> ())? = nil
    
    fileprivate var headerBar: UIView = UIView()
    
    var nameInputView: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 17)
        return view
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
        
        addSubview(nameInputView)
        nameInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(headerBar.snp.bottom)
            make.height.equalTo(50)
        }
        
        let topView = UIToolbar(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: 30))
        topView.barStyle = .default
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(dismissKeyBoard))
        topView.items = [btnSpace, doneButton]
        nameInputView.inputAccessoryView = topView
        
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
            self.nameInputView.becomeFirstResponder()
        }
    }
    
    @objc fileprivate func pushAction() {
        close()
        if let message = nameInputView.text {
            iToast.makeText("昵称修改成功啦~").show()
            nameChangeSuccesClosure?(message)
        } else {
            iToast.makeText("修改失败啦😑").show()
            nameChangeSuccesClosure?("...")
        }
    }
    
    @objc func close() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        nameInputView.resignFirstResponder()
        UIView.animate(withDuration: 0.4, animations: {
            self.setTop(BBSScreenHeight)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func dismissKeyBoard() {
        nameInputView.resignFirstResponder()
    }
}
