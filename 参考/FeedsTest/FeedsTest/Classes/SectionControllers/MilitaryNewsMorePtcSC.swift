//
//  MilitaryNewsOnePtcSC.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

// 军事新闻只显示多张图片的SectionController
final class MilitaryNewsMorePtcSC: ListSectionController {
    
    weak var delegate: BaseSectionControllerDelegate?
    private var object: MilitaryNewsMorePicCellViewModel?
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let obj = object {
            let height = MilitaryNewsMorePicCell.textHeight(obj.title, width: UIScreen.main.bounds.width)
            return CGSize(width: collectionContext!.containerSize.width, height: height+160)
        } else {
            fatalError()
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: MilitaryNewsMorePicCell.nibName, bundle: nil, for: self, at: index) as? MilitaryNewsMorePicCell else {
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
    
    fileprivate func modelTrans(model: BaseModel) -> MilitaryNewsMorePicCellViewModel {
        let title = model.title as String
        var urls: [String] = []
        for obj in model.image_list {
            if let url = obj.url {
                urls.append(url)
            }
        }
        return MilitaryNewsMorePicCellViewModel(title: title, urls: urls, articleUrl: model.article_url)
    }
}
