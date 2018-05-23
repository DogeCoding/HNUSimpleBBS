//
//  FeedViewController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

protocol RefreshingSectionControllerProtocol {
    func refreshContent(withCompletion completion: @escaping () -> ())
}

class FeedViewController: ASViewController<ASCollectionNode>, ListAdapterDataSource, ASCollectionDelegate {
    
    fileprivate var data: WeiboViewModel = WeiboViewModel()
    
    fileprivate var collectionNode: ASCollectionNode {
        return node
    }
    
    lazy fileprivate var listAdaper: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    lazy fileprivate var refreshCtrl = UIRefreshControl()
    
    lazy fileprivate var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init() {
        let layout = UICollectionViewFlowLayout()
        let node = ASCollectionNode.init(collectionViewLayout: layout)
        super.init(node: node)
        
        listAdaper.dataSource = self
        listAdaper.setASDKCollectionNode(collectionNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionNode.view.alwaysBounceVertical = true
        refreshCtrl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        collectionNode.view.addSubview(refreshCtrl)
        
    }
    
    @objc fileprivate func refreshFeed() {
        guard let secCtrl = listAdaper.sectionController(for: data) as? WeiboFeedSectionController else { return }
        secCtrl.refreshContent {
            self.refreshCtrl.endRefreshing()
        }
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [data] as [ListDiffable]
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        spinner.startAnimating()
        return spinner
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let _ = object as? WeiboViewModel {
            return WeiboFeedSectionController()
        }
        return ListSectionController()
    }
    
}
