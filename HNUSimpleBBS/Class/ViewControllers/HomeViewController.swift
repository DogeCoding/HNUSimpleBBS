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
    
    init() {
        let layout = UICollectionViewLayout()
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






