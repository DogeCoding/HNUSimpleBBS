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
    
    fileprivate var currentVC: UIViewController? = nil
    
    fileprivate var vcArray: [UIViewController] = []
    
    fileprivate let titlesArray: [String] = ["推荐", "学术活动", "就业信息", "教务处", "长沙热点"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: Private
    fileprivate func setupUI() {
        contentView.frame = CGRect(x: 0, y: 0, width: BBSScreenWidth, height: BBSScreenHeight)
        contentView.delegate = self
        view.addSubview(contentView)
        var contentH = BBSScreenHeight
        if IsIphone_X {
            contentH = BBSScreenHeight-44-101
            contentView.frame = CGRect(x: 0, y: 44, width: BBSScreenWidth, height: contentH)
        }
        contentView.contentSize = CGSize(width: BBSScreenWidth, height: contentH+0.5)
        
        segmentControl = BBSSegmentControl(titles: titlesArray)
        segmentControl?.addTarget(self, action: #selector(segmentControl(action:)), for: .valueChanged)
        contentView.addSubview(segmentControl!)
        
        for _ in 0..<titlesArray.count {
            vcArray.append(FeedViewController())
        }
        
        segmentControl?.selectedIndex = lastSelectedSegmentIndex
    }
    
    @objc fileprivate func segmentControl(action sender: BBSSegmentControl) {
        if lastSelectedSegmentIndex != sender.selectedIndex {
            guard let oldCurrent = currentVC else { return }
            transition(from: oldCurrent, to: vcArray[sender.selectedIndex], duration: 0, options: .transitionFlipFromRight, animations: nil) { [weak self] (finished) in
                self?.currentVC = self?.vcArray[sender.selectedIndex]
            }
            if sender.selectedIndex == 0 {
                
            }
        }
    }
}








