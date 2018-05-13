//
//  AlbumViewSectionController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

class AlbumViewSectionController: ListSectionController {
    
    weak var delegate: BaseSectionControllerDelegate?
    private var object: JokeOrPctCellViewModel?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 500)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: JokeOrPctCell.nibName, bundle: nil, for: self, at: index) as? JokeOrPctCell else {
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
    
    fileprivate func modelTrans(model: BaseModel) -> JokeOrPctCellViewModel {
        let content = model.content
        let largeImageUrl = model.large_image?.url
        
        return JokeOrPctCellViewModel(content: content, largeImageUrl: largeImageUrl, isJoke: false)
    }
}
