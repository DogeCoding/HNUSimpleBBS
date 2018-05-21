//
//  LoginModuel.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class LoginModuel: NSObject {
    var isLogin: Bool = false
    
    static let shared = LoginModuel().then { _ in
        
    }
    
    fileprivate override init() {
        super.init()
    }
    
    func showLoginContinue(_ closure: @escaping () -> ()) {
        if !isLogin {
            let loginViewController = LoginViewController()
            loginViewController.loginSuccessClosure = closure
            RootViewController.navigationController?.pushViewController(loginViewController, animated: false)
        }
    }
    
    fileprivate func showLoginView() {
        
    }
}
