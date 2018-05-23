//
//  WeiboFeedSectionController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/18.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

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

class WeiboFeedSectionController: BaseSectionController, ASSectionController, RefreshingSectionControllerProtocol, ASSupplementaryNodeSource, ListSupplementaryViewSource {

    var viewModel: WeiboViewModel

    fileprivate var paginatingSpinner: Spinner

    override init() {
        viewModel = WeiboViewModel()
        paginatingSpinner = Spinner()
        super.init()
        supplementaryViewSource = self
    }

    // MARK: ListSectionType
    override func didUpdate(to object: Any) {
        guard let data = object as? WeiboViewModel else {
            viewModel = WeiboViewModel()
            return
        }
        viewModel = data
        set(items: viewModel.datas, animated: true)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }

    override func didSelectItem(at index: Int) {
        print("select \(index)")
        iToast.makeText("马上做完了🤣").show()
    }

    // MARK: ASSectionController
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let object = items[index]
        var nodeClosure: () -> ASCellNode
        if let object = object as? Spinner, object == paginatingSpinner {
            nodeClosure = {
                return TailLoadingNode()
            }
        } else if let object = object as? WeiboModel {
            nodeClosure = {
                return WeiboCellNode(weiboModel: object)
            }
        } else {
            nodeClosure = {
                return ASCellNode()
            }
        }
        return nodeClosure
    }

    func beginBatchFetch(with context: ASBatchContext) {
        DispatchQueue.main.async {
            if self.items.count > 0 {
                let newItems = self.items
//                newItems.append(self.paginatingSpinner)
                self.set(items: newItems, animated: false)
            }
            self.viewModel.requestDatas(withDataType: .weibo, { (newModels) in
                self.set(items: self.viewModel.datas, animated: false) {
                    context.completeBatchFetching(true)
                }
            })

        }
    }

    // MARK: RefreshingSectionControllerType
    internal func refreshContent(withCompletion completion: @escaping () -> ()) {
    
        viewModel.refreshDatas(withDataType: .weibo, { (newItems) in
            self.set(items: self.viewModel.datas, animated: true, completion)
        })
    }

    // MARK: ASSupplementaryNodeSource
    func nodeBlockForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASCellNodeBlock {
        assert(elementKind == UICollectionElementKindSectionHeader)
        return {
            return FeedHeaderNode()
        }
    }

    func sizeRangeForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASSizeRange {
        if elementKind == UICollectionElementKindSectionHeader {
            return ASSizeRangeUnconstrained
        } else {
            return ASSizeRangeZero
        }
    }

    // MARK: ListSupplementaryViewSource
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        return ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(ofKind: elementKind, at: index, sectionController: self)
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return ASIGListSupplementaryViewSourceMethods.sizeForSupplementaryView(ofKind: elementKind, at: index)
    }
}

