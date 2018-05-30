//
//  SettingViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/30.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bar = BBSNavigationBar().setBottomLineStyle().place(at: self)
        bar.backgroundColor = .clear
        view.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.equalTo(view)
            make.height.equalTo(BBSNavigationBarHeight)
        }
        
        let logoutBtn = UIButton()
        logoutBtn.setTitle("注销", for: .normal)
        logoutBtn.setTitleColor(.black, for: .normal)
        logoutBtn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        logoutBtn.backgroundColor = UIColorFromRGB(0xE4E1C9)
        view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bar.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
    }
    
    @objc fileprivate func handleLogout() {
        
        LoginModuel.shared.isLogin = false
        iToast.makeText("已经退出登录了").show()
        let vc = RootViewController.navigationController!.popToStackViewController(withClassName: "SettingViewController", animated: false)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
        RootViewController.handleClickHome()
        LoginModuel.shared.showLoginContinue(false) { (userInfo) in
            
        }

    }
    
}
