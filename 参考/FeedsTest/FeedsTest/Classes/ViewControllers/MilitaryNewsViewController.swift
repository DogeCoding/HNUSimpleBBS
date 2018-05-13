//
//  HotViewController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/31.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

class MilitaryNewsViewController: UIViewController, ListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    fileprivate let category = "news_military"
    var data: [BaseModel] = []
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        // 数据保存在内存中，不超过40条
        collectionView.mj_header = MJRefreshNormalHeader() { [weak self] () -> Void in
            guard let `self` = self else { return }
            Network.loadCategoryNewsFeeds(category: self.category) { (nowTime, newsFeeds) in
                let num = self.data.count
                if num >= 40 {
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
        
//        collectionView.mj_footer = MJRefreshBackNormalFooter() { [weak self] () -> Void in
//            if !(self?.loading)! {
//                self?.loading = true
//                self?.adapter.performUpdates(animated: true, completion: nil)
//                DispatchQueue.global(qos: .default).async {
//                    sleep(2)
//                    DispatchQueue.main.async {
//                        self?.loading = false
//                        let itemCount = self!.items.count
//                        self!.items.append(contentsOf: Array(itemCount..<itemCount + 5))
//                        self?.adapter.performUpdates(animated: true, completion: nil)
//                        self?.collectionView.mj_footer.endRefreshing()
//                    }
//                }
//            }
//        }
        
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
        if let obj = object as? BaseModel {
            if let hasImage = obj.has_image {
                if hasImage {
                    if obj.image_list.count >= 0 {
                        let ctr = MilitaryNewsMorePtcSC()
                        ctr.delegate = self
                        return ctr
                    }
                }
            } else if let hasVideo = obj.has_video {
                if hasVideo {
                    if obj.middle_image != nil {
                        let ctr = MilitaryNewsOnePtcSC()
                        ctr.delegate = self
                        return ctr
                    }
                }
            }
        }
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

// SectionController的传递
extension MilitaryNewsViewController: BaseSectionControllerDelegate {
    func didSelect(data: Any) {
        var articleUrl = ""
        if let data = data as? MilitaryNewsMorePicCellViewModel {
            if let url = data.article_url {
                articleUrl = url
            }
        } else if let data = data as? MilitaryNewsOnePicCellViewModel {
            if let url = data.article_url {
                articleUrl = url
            }
        }
        let newsCtr = MilitaryNewsDetailViewController()
        newsCtr.article_url = articleUrl
    
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(newsCtr, animated: true)
    }
}
