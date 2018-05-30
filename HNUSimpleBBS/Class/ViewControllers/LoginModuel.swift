//
//  LoginModuel.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class LoginModuel: NSObject {
    var isLogin: Bool = false
    
    var userInfo: BaseModel = {
        let model = BaseModel()
        model.userAvatarUrl = "http://oo8snaf4x.bkt.clouddn.com/WechatIMG10.jpeg"
        return model
    }()
    
    static let shared = LoginModuel().then { _ in
        
    }
    
    fileprivate override init() {
        super.init()
    }
    
    func showLoginContinue(_ isShowToast: Bool = true, _ closure: @escaping (_ userInfo: BaseModel) -> ()) {
        if !isLogin {
            if isShowToast {
                iToast.makeText("小宝贝请先登录哦😯").show()
            }
            let loginViewController = LoginViewController()
            loginViewController.userInfo = userInfo
            loginViewController.loginSuccessClosure = closure
            RootViewController.navigationController?.pushViewController(loginViewController, animated: false)
        } else {
            closure(userInfo)
        }
    }
    
    fileprivate func showLoginView() {
        
    }
}
