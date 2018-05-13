//
//  MilitaryNewsOnePtcSC.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

// 军事新闻只显示一张图片的SectionController
final class MilitaryNewsOnePtcSC: ListSectionController {
    
    weak var delegate: BaseSectionControllerDelegate?
    private var object: MilitaryNewsOnePicCellViewModel?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 150)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: MilitaryNewsOnePicCell.nibName, bundle: nil, for: self, at: index) as? MilitaryNewsOnePicCell else {
            fatalError()
        }
        cell.data = object!
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let object = object as? BaseModel {
            self.object = modelTrans(model: object)
        } else {
            fatalError()
        }
    }
    
    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)
        delegate?.didSelect(data: object as Any)
    }
    
    // 把BaseModel转化为ViewModel
    fileprivate func modelTrans(model: BaseModel) -> MilitaryNewsOnePicCellViewModel {
        let title = model.title as String
        if let url = model.middle_image?.url {
            return MilitaryNewsOnePicCellViewModel(title: title, url: url, articleUrl: model.article_url)
        }
        let url = ""
        return MilitaryNewsOnePicCellViewModel(title: title, url: url, articleUrl: model.article_url)
    }
}
