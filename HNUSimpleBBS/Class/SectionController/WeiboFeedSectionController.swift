//
//  WeiboFeedSectionController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class WeiboFeedSectionController: BaseSectionController, ASSectionController, ASSupplementaryNodeSource, ListSupplementaryViewSource {
    
    var models: [WeiboViewModel]
    
    fileprivate var paginatingSpinner: String
    
    override init() {
        paginatingSpinner = "Paginating Spinner"
        supplementaryViewSource = self
    }
    
    // MARK: ListSectionType
    override func didUpdate(to object: Any) {
        guard let datas = object as? [WeiboViewModel] else {
            models = []
            return
        }
        models = datas
        set(datas: models, animated: true)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override func didSelectItem(at index: Int) {
        print("select \(index)")
    }
    
    // MARK: ASSectionController
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        var object = datas[index]
        var nodeClosure: ASCellNode
        
    }
}
