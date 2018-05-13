//
//  LabelSectionController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/31.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

// 默认
final class LabelSectionController: ListSectionController {
    
    private var object: String?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 150)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as? LabelCell else {
            fatalError()
        }
        cell.text = object
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = String(describing: object)
    }
}
