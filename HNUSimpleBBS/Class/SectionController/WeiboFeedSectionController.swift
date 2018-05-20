//
//  WeiboFeedSectionController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let ElementKindSectionHeader = "UICollectionElementKindSectionHeader"

fileprivate class Spinner: NSObject, ListDiffable {
    var paginatingSpinner: String = "Paginating Spinner"
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Spinner {
            return self == object
        }
        return false
    }
}

//class WeiboFeedSectionController: BaseSectionController, ASSectionController, ASSupplementaryNodeSource, ListSupplementaryViewSource {
//
//    var models: [WeiboViewModel]
//
//    fileprivate var paginatingSpinner: Spinner
//
//    override init() {
//        models = []
//        paginatingSpinner = Spinner()
//        supplementaryViewSource = self
//        super.init()
//    }
//
//    // MARK: ListSectionType
//    override func didUpdate(to object: Any) {
//        guard let datas = object as? [WeiboViewModel] else {
//            models = []
//            return
//        }
//        models = datas
//        set(items: models, animated: true)
//    }
//
//    override func cellForItem(at index: Int) -> UICollectionViewCell {
//        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
//    }
//    
//    override func sizeForItem(at index: Int) -> CGSize {
//        return ASIGListSectionControllerMethods.sizeForItem(at: index)
//    }
//
//    override func didSelectItem(at index: Int) {
//        print("select \(index)")
//    }
//
//    // MARK: ASSectionController
//    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
//        let object = items[index]
//        var nodeClosure: () -> ASCellNode
//        if let object = object as? Spinner, object == paginatingSpinner {
//            nodeClosure = {
//                return TailLoadingNode()
//            }
//        } else if let object = object as? WeiboViewModel {
//            nodeClosure = {
//                return WeiboCellNode(weiboViewModel: object)
//            }
//        }
//        return nodeClosure
//    }
//
//    func beginBatchFetch(with context: ASBatchContext) {
//        DispatchQueue.main.async {
//            if self.items.count > 0 {
//                var newItems = self.items
//                newItems.append(self.paginatingSpinner)
//                self.set(items: newItems, animated: false)
//            }
//
//
//        }
//    }
//
//    // MARK: RefreshingSectionControllerType
//    fileprivate func refreshContent(withCompletion completion: () -> ()) {
//
//    }
//
//    // MARK: ASSupplementaryNodeSource
//    func nodeBlockForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASCellNodeBlock {
//        assert(elementKind == ElementKindSectionHeader, nil)
//        return {
//            return FeedHeaderNode()
//        }
//    }
//
//    func sizeRangeForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASSizeRange {
//        if elementKind == ElementKindSectionHeader {
//            return ASSizeRangeUnconstrained
//        } else {
//            return ASSizeRangeZero
//        }
//    }
//
//    // MARK: ListSupplementaryViewSource
//    func supportedElementKinds() -> [String] {
//        return [ElementKindSectionHeader]
//    }
//
//    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
//        return ASIGListSupplementaryViewSourceMethods.
//    }
//}

