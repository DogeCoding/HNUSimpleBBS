//
//  BaseSectionController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BaseSectionController: ListSectionController {
    fileprivate(set) var datas: Array<ListDiffable> = []
    
    var numberOfDatas: NSInteger {
        if !initialDatasRead {
            pendingDatas = datas
            initialDatasRead = true
        }
        return datas.count
    }
    
    fileprivate let diffingQueue: DispatchQueue = DispatchQueue(label: "BaseSectionController.diffingQueue")
    
    fileprivate var pendingDatas: Array<ListDiffable> = []
    
    fileprivate var initialDatasRead: Bool = true
    
    func set(datas: Array<ListDiffable>, animated: Bool, _ completion: @escaping ()->()? = nil) {
        AssertMainThread()
        if !initialDatasRead {
            self.datas = datas
            completion()
            return
        }
            
        self.diffingQueue.async {
            let result = ListDiff(oldArray: self.pendingDatas, newArray: datas, option: .pointerPersonality)
            self.pendingDatas = datas
            dispatch_main_async_safe {
                let ctx = self.collectionContext
                ctx?.performBatch(animated: animated, updates: { (batchContext) in
                    batchContext.insert(in: self, at: result.inserts)
                    batchContext.delete(in: self, at: result.deletes)
                }, completion: { (finished) in
                    completion()
                })
            }
        }
    }

}
