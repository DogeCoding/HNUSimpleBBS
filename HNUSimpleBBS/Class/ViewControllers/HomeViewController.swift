//
//  HomeViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    lazy fileprivate var segmentControl: BBSSegmentControl? = nil
    
    fileprivate var contentView: UIScrollView = UIScrollView()
    
    fileprivate var lastSelectedSegmentIndex: NSInteger = 0
    
    fileprivate var currentVC: FeedViewController? = nil
    
    fileprivate var vcArray: [FeedViewController] = []
    
    fileprivate let titlesArray: [String] = ["推荐", "学术活动", "就业信息", "教务处", "长沙热点"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.defaultYellow()
    }
    
    // MARK: Private
    fileprivate func setupUI() {
        contentView.frame = CGRect(x: 0, y: 0, width: BBSScreenWidth, height: BBSScreenHeight)
        contentView.delegate = self
//        view.addSubview(contentView)
        var contentH = BBSScreenHeight
        if IsIphone_X {
            contentH = BBSScreenHeight-44-101
            contentView.frame = CGRect(x: 0, y: 44, width: BBSScreenWidth, height: contentH)
        }
        contentView.contentSize = CGSize(width: BBSScreenWidth, height: contentH+0.5)
        
        segmentControl = BBSSegmentControl(titles: titlesArray)
        segmentControl?.addTarget(self, action: #selector(segmentControl(action:)), for: .valueChanged)
        view.addSubview(segmentControl!)
        segmentControl?.setTop(20)
        
        for _ in 0..<titlesArray.count {
            vcArray.append(FeedViewController())
        }
        
        segmentControl?.selectedIndex = lastSelectedSegmentIndex
        switchVC(vc: vcArray[lastSelectedSegmentIndex])
//        RootViewController.navigationController?.pushViewController(vcArray[0], animated: false)
    }
    
    @objc fileprivate func segmentControl(action sender: BBSSegmentControl) {
//        if lastSelectedSegmentIndex != sender.selectedIndex {
//            lastSelectedSegmentIndex = sender.selectedIndex
//            guard let oldCurrent = currentVC else { return }
//            let goalVC = vcArray[sender.selectedIndex]
//            transition(from: oldCurrent, to: goalVC, duration: 0, options: .transitionFlipFromRight, animations: nil) { [weak self] (finished) in
//                self?.currentVC = goalVC
//            }
//            if sender.selectedIndex == 0 {
//
//            }
//        }
        let vc = vcArray[sender.selectedIndex]
        switchVC(vc: vc)
        
    }
    
    fileprivate func switchVC(vc: FeedViewController) {
        guard let segmentControl = segmentControl else { return }
        if let currentVC = currentVC {
            if currentVC != vc {
                currentVC.view.removeFromSuperview()
                currentVC.removeFromParentViewController()
                
                addChildViewController(vc)
                vc.view.frame = view.bounds
                view.insertSubview(vc.view, at: 0)
                vc.view.snp.makeConstraints { (make) in
                    make.top.equalTo(segmentControl.snp.bottom)
                    make.left.right.bottom.equalTo(view)
//                    make.edges.equalTo(view)
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
                make.top.equalTo(segmentControl.snp.bottom)
                make.left.right.bottom.equalTo(view)
//                make.edges.equalTo(view)
            }
            vc.didMove(toParentViewController: self)
            self.currentVC = vc
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}








