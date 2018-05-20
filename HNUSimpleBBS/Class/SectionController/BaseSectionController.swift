//
//  BaseSectionController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BaseSectionController: ListSectionController {
    fileprivate(set) var items: Array<ListDiffable> = []
    
    override func numberOfItems() -> Int {
        if !initialDatasRead {
            pendingItems = items
            initialDatasRead = true
        }
        return items.count
    }
    
    fileprivate let diffingQueue: DispatchQueue = DispatchQueue(label: "BaseSectionController.diffingQueue")
    
    fileprivate var pendingItems: Array<ListDiffable> = []
    
    fileprivate var initialDatasRead: Bool = true
    
    func set(items newItems: Array<ListDiffable>, animated: Bool, _ completion: (()->())? = nil) {
        AssertMainThread()
        if !initialDatasRead {
            items = newItems
            completion?()
            return
        }
            
        self.diffingQueue.async {
            let result = ListDiff(oldArray: self.pendingItems, newArray: newItems, option: .pointerPersonality)
            self.pendingItems = newItems
            dispatch_main_async_safe {
                let ctx = self.collectionContext
                ctx?.performBatch(animated: animated, updates: { (batchContext) in
                    batchContext.insert(in: self, at: result.inserts)
                    batchContext.delete(in: self, at: result.deletes)
                    self.items = newItems
                }, completion: { (finished) in
                    completion?()
                })
            }
        }
    }

}
