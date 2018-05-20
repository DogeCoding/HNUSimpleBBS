//
//  LoginModuel.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class LoginModuel: NSObject {
    var isLogin: Bool = false
    
    fileprivate var loginView: UIView
    
    static let shared = LoginModuel().then { _ in
        
    }
    
    fileprivate override init() {
        loginView = UIView(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: BBSScreenHeight-BBSTabbarHeight))
        super.init()
    }
    
    class func showLoginContinue(_ closure: () -> ()) {
        
    }
    
    fileprivate func showLoginView() {
        guard let window = BBSWindows.first else { return }
        
    }
}
