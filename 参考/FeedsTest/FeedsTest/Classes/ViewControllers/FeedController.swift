//
//  ViewController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/27.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import UIKit
import SnapKit
import Segmentio

class FeedController: UIViewController {

    var segmentioView: FTSegmentioView?
    var scrollView: UIScrollView?
    var testButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    fileprivate lazy var viewControllers: [UIViewController] = {
        return preparedViewControllers()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "FeedsTest"

        let btn = UIButton()
        let width: CGFloat = 100
        btn.frame = CGRect(x: (UIScreen.main.bounds.width-width)/2, y: (UIScreen.main.bounds.height-width)/2, width: width, height: width)
        btn.backgroundColor = .red
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)

        
//        segmentioView = FTSegmentioView()
//        view.addSubview(segmentioView!)
//
//        setupScrollView()
//
//        segmentioView?.build()
//        segmentioView?.selectedSegmentioIndex = 0
//        segmentioView?.valueDidChange = { [weak self] _, segmentIndex in
//            if let scrollViewWidth = self?.scrollView?.frame.width {
//                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
//                self?.scrollView?.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
//            }
//        }
    }
    
    @objc func click() {
        present(TestViewController(), animated: true, completion: nil)
    }
    
    @objc func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        segmentioView!.snp.makeConstraints { (make) -> Void in
//            make.top.equalToSuperview().offset(navigationBarHeight)
//            make.width.equalToSuperview()
//            make.height.equalTo(50)
//        }
    }
    
    func setupScrollView() {
        let width = UIScreen.main.bounds.width
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        scrollView?.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo((segmentioView?.snp.bottom)!)
            make.height.equalToSuperview().offset(-(segmentioView?.frame.height)!)
            make.width.equalTo(width)
        }
        scrollView?.contentSize = CGSize(width: width * CGFloat(viewControllers.count), height: UIScreen.main.bounds.height-(segmentioView?.frame.height)!-navigationBarHeight)
        scrollView?.delegate = self
        scrollView?.bounces = false
        scrollView?.isPagingEnabled = true
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(x: width * CGFloat(index), y: 0, width: (scrollView?.frame.width)!, height: (scrollView?.frame.height)!)
            addChildViewController(viewController)
            scrollView?.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }

    fileprivate func preparedViewControllers() -> [UIViewController] {
        let militaryNewsViewController = MilitaryNewsViewController()
        
        let albumViewController = AlbumViewController()
        
        let jokeViewController = JokeViewController()

        return [
            militaryNewsViewController,
            albumViewController,
            jokeViewController
        ]
    }
    
    
}

extension FeedController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floorf(Float(scrollView.contentOffset.x / scrollView.frame.width))
        segmentioView?.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}


