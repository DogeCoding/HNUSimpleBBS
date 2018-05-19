//
//  UIScrollView+BBSMJRefresh.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UIScrollView {
    func addUpTo(loadingTarget target: Any, finishAction action: Selector) -> MJRefreshAutoGifFooter? {
        let footer = MJRefreshAutoGifFooter(refreshingTarget: target, refreshingAction: action)
        footer?.setImages(__spinImages(), duration: 1.5, for: .refreshing)
        footer?.isRefreshingTitleHidden = true
        footer?.stateLabel.textColor = UIColorFromRGB(0x777A89)
        footer?.setTitle("没有更多内容啦", for: .noMoreData)
        
        mj_footer = footer
        return footer
    }
    
    func addPullTo(refreshTarget target: Any, finishAction: Selector) -> MJRefreshGifHeader? {
        let header = MJRefreshGifHeader(refreshingTarget: target, refreshingAction: finishAction)
        let array = __spinImages()
        header?.setImages(array, for: .idle)
        header?.setImages(array, for: .pulling)
        header?.setImages(array, duration: 1.5, for: .refreshing)
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放刷新", for: .pulling)
        header?.setTitle("正在刷新", for: .refreshing)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.stateLabel.isHidden = true
        mj_header = header
        return header
    }
    
    fileprivate func __spinImages() -> Array<UIImage> {
        var name = ""
        var array: [UIImage] = []
        for i in 1...36 {
            if i < 10 {
                name = "pullRefresh0\(i)"
            } else {
                name = "pullRefresh\(i)"
            }
            if let image = UIImage(named: name) {
                array.append(image)
            }
        }
        return array
    }
}
