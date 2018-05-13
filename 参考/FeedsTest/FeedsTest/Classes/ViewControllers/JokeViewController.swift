//
//  SocietyViewController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/31.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

class JokeViewController: UIViewController, ListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    fileprivate let category = "essay_joke"
    var data: [BaseModel] = []
    
    override func viewDidLoad() {
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        
        collectionView.mj_header = MJRefreshNormalHeader() { [weak self] () -> Void in
            guard let `self` = self else { return }
            Network.loadCategoryNewsFeeds(category: self.category) { (nowTime, newsFeeds) in
                let num = self.data.count
                if num >= 30 {
                    self.data.removeSubrange(Range<Int>(num-newsFeeds.count..<num))
                }
                self.data.insert(contentsOf: newsFeeds, at: 0)
                
                self.adapter.performUpdates(animated: true, completion: nil)
                self.collectionView.mj_header.endRefreshing()
            }
        }
        collectionView.mj_header.isAutomaticallyChangeAlpha = false
        collectionView.mj_header.scrollView.backgroundColor = .white
        collectionView.mj_header.beginRefreshing()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let obj = object as? BaseModel, obj.content != nil {
            let ctr = JokeViewSectionController()
            ctr.delegate = self
            return ctr
        }
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension JokeViewController: BaseSectionControllerDelegate {
    func didSelect(data: Any) {
//        if let data = data as? JokeOrPctCellViewModel, let url = data.large_image_url {
//            let detailCtr = AlbumDetailViewController()
//            detailCtr.url = url
//            navigationController?.pushViewController(detailCtr, animated: true)
//        }
    }
    
    
}
