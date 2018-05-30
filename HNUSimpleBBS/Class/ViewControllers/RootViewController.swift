//
//  RootViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSRootViewController: UIViewController {
    
    var homeVC = HomeViewController()
    var messageVC = MessageViewController()
    var addVC = PublishMessageViewController()
    var scheduleVC = SheduleViewController()
    var mineVC = MineViewController()
    fileprivate var tab = BBSTabbar()
    
    fileprivate var currentVC: UIViewController? = nil
    
    static let shared: BBSRootViewController = {
        let vc = BBSRootViewController()
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        tab = tab.plaveAt(viewController: self)
        handleClickHome()
        tab.homeBtn.addTarget(self, action: #selector(handleClickHome), for: .touchUpInside)
        tab.messageBtn.addTarget(self, action: #selector(handleClickMessage), for: .touchUpInside)
        tab.addBtn.addTarget(self, action: #selector(handleClickAdd), for: .touchUpInside)
        tab.scheduleBtn.addTarget(self, action: #selector(handleClickSchedule), for: .touchUpInside)
        tab.mineBtn.addTarget(self, action: #selector(handleClickMine), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubview(toFront: tab)
        NotificationCenter.default.post(name: Notification.Name(BBSTabBarHasBringToFrontNotification), object: nil)
    }
    
    fileprivate func switchTabBarViewControllerTo(viewController vc: UIViewController) {
        if let currentVC = currentVC {
            if currentVC != vc {
                currentVC.view.removeFromSuperview()
                currentVC.removeFromParentViewController()
                
                addChildViewController(vc)
                vc.view.frame = view.bounds
                view.insertSubview(vc.view, at: 0)
                vc.view.snp.makeConstraints { (make) in
                    make.top.left.right.equalTo(view)
                    make.bottom.equalTo(tab.snp.top)
                }
                vc.didMove(toParentViewController: self)
                self.currentVC = vc
                setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            addChildViewController(vc)
            vc.view.frame = view.bounds
            view.insertSubview(vc.view, at: 0)
            vc.view.snp.makeConstraints { (make) in
                make.top.left.right.equalTo(view)
                make.bottom.equalTo(tab.snp.top)
            }
            vc.didMove(toParentViewController: self)
            self.currentVC = vc
            setNeedsStatusBarAppearanceUpdate()
        }
        
        
    }
    
    @objc func handleClickHome() {
        tab.homeBtn.isSelected = true
        tab.messageBtn.isSelected = false
        tab.scheduleBtn.isSelected = false
        tab.mineBtn.isSelected = false
//        view.backgroundColor = AppTintColor
        if let currentVC = currentVC {
            if currentVC == homeVC {
                
            }
        }
        switchTabBarViewControllerTo(viewController: homeVC)
    }
    
    @objc func handleClickMessage() {
        tab.homeBtn.isSelected = false
        tab.messageBtn.isSelected = true
        tab.scheduleBtn.isSelected = false
        tab.mineBtn.isSelected = false
//        view.backgroundColor = .white
        switchTabBarViewControllerTo(viewController: messageVC)
    }
    
    @objc func handleClickAdd() {
        LoginModuel.shared.showLoginContinue { (userInfo) in
            RootViewController.navigationController?.pushViewController(self.addVC, animated: false)
        }
    }
    
    @objc func handleClickSchedule() {
        tab.homeBtn.isSelected = false
        tab.messageBtn.isSelected = false
        tab.scheduleBtn.isSelected = true
        tab.mineBtn.isSelected = false
        switchTabBarViewControllerTo(viewController: scheduleVC)
    }
    
    @objc func handleClickMine() {
        LoginModuel.shared.showLoginContinue { (userInfo) in
            self.tab.homeBtn.isSelected = false
            self.tab.messageBtn.isSelected = false
            self.tab.scheduleBtn.isSelected = false
            self.tab.mineBtn.isSelected = true
            self.mineVC.data = userInfo
            self.switchTabBarViewControllerTo(viewController: self.mineVC)
        }
    }
}





