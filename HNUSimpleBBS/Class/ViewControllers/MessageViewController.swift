//
//  MessageViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let cellID = "MessageNormalCell"
fileprivate let footerID = "BBSMessageFooterView"

class MessageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: BBSScreenWidth, height: 50)
        layout.itemSize = CGSize(width: BBSScreenWidth, height: 100)
        layout.minimumLineSpacing = 3
        layout.scrollDirection = .vertical
        let frame = CGRect(x: 0, y: 20, width: BBSScreenWidth, height: BBSScreenHeight-BBSTabbarHeight-20)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        return collectionView
    }()
    
    var viewModel: MessageViewModel = MessageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTintColor
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        collectionView.scrollsToTop = true
        
        collectionView.register(MessageNormalCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(BBSMessageFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        _ = collectionView.addPullTo(refreshTarget: self, finishAction: #selector(handlePullToRefresh))
        handlePullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: PullData
    @objc fileprivate func handlePullToRefresh() {
        viewModel.requestDatas(withDataType: .user) { [weak self] (datas) in
            if let `self` = self {
                self.collectionView.reloadData()
                self.collectionView.mj_header.endRefreshing()
            }
        }
    }
    
    // MARK: ColloctionDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MessageNormalCell else {
            return UICollectionViewCell()
        }
        if let data = viewModel.datas[indexPath.row] as? UserModel {
            cell.data = data
        } else {
            cell.data = UserModel()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID, for: indexPath) as? BBSMessageFooterView else {
                return UICollectionReusableView()
            }
            footerView.updateTip(isHasData: viewModel.datas.count > 0, isHasMore: false)
            return footerView
        }
        let view = UICollectionReusableView()
        view.backgroundColor = .clear
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MessageDetailViewController()
        guard let model = viewModel.datas[indexPath.row] as? UserModel else { return }
        vc.model = model
        RootViewController.navigationController?.pushViewController(vc, animated: false)
    }
}
