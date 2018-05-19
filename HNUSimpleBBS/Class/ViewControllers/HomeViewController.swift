//
//  HomeViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class HomeViewController: ASViewController<ASCollectionNode>, ListAdapterDataSource, ASCollectionDelegate {
    
    fileprivate var datas: [WeiboViewModel] = []
    
    fileprivate var collectionNode: ASCollectionNode {
        return node
    }
    
    lazy fileprivate var listAdaper: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    lazy fileprivate var refreshCtrl = UIRefreshControl()
    
    lazy fileprivate var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    lazy fileprivate var segmentControl: BBSSegmentControl = BBSSegmentControl()
    
    fileprivate var contentView: UIScrollView = UIScrollView()
    
    init() {
        let layout = UICollectionViewLayout()
        let node = ASCollectionNode.init(collectionViewLayout: layout)
        super.init(node: node)
        setupUI()
        
        listAdaper.dataSource = self
        listAdaper.setASDKCollectionNode(collectionNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: 100))
        testView.backgroundColor = .red
        view.addSubview(testView)
        
        collectionNode.view.alwaysBounceVertical = true
        refreshCtrl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        collectionNode.view.addSubview(refreshCtrl)
        
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
        
        
        
        segmentControl = BBSSegmentControl(titles: ["推荐", "学术活动", "就业信息", "教务处", "长沙热点"])
        segmentControl.addTarget(self, action: #selector(segmentControl(action:)), for: .valueChanged)
        view.addSubview(segmentControl)
        segmentControl.setTop(20)
    }
    
    @objc fileprivate func refreshFeed() {
        
    }
    
    @objc fileprivate func segmentControl(action sender: BBSSegmentControl) {
        
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return datas as [ListDiffable]
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        spinner.startAnimating()
        return spinner
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let _ = object as? WeiboViewModel {
//            return Weibobase
        }
        return ListSectionController()
    }
    
}








