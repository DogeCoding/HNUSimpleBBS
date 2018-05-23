//
//  MessageViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class MessageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: BBSScreenWidth-20, height: 1 / BBSScreenScale)
        layout.itemSize = CGSize(width: BBSScreenWidth, height: 62)
        layout.minimumLineSpacing = 26
        layout.scrollDirection = .vertical
        let frame = CGRect(x: 0, y: 24, width: BBSScreenWidth, height: BBSScreenHeight-BBSTabbarHeight-24)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        return collectionView
    }()
    var footerView: UICollectionReusableView
    
    var viewModel: MessageViewModel {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTintColor
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        
        collectionView.register(MessageNormalCell.self, forCellWithReuseIdentifier: "MessageNormalCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "UICollectionReusableView")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(24)
            make.left.right.bottom.equalTo(view)
        }
        viewModel.requestDatas(withDataType: .user) { _ in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
