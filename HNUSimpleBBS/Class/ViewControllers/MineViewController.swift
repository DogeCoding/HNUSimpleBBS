//
//  MineViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let avatarImgHeight: CGFloat = 120

class MineViewController: UIViewController {
    
    var data: BaseModel? {
        didSet {
            avatarImg.kf.setImage(with: URL(string: data!.userAvatarUrl))
            userNameLabel.text = data!.userName
        }
    }
    
    var avatarImg: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "icon_avatarImg"))
        avatar.layer.cornerRadius = avatarImgHeight/2
        avatar.layer.masksToBounds = true
        avatar.contentScaleFactor = BBSScreenScale
        avatar.contentMode = .scaleAspectFill
        return avatar
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "没有昵称哦"
        label.textAlignment = .center
        label.font = UIFont.bbs_defaultFontWith(size: 17)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        let bar = BBSNavigationBar().setTransparentStyle().place(at: self)
        bar.backBtn = nil
//        bar.barItem.leftBarButtonItem = nil
        bar.barItem.leftBarButtonItems = nil
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
        rightBtn.setTitle("设置", for: .normal)
        rightBtn.setTitleColor(UIColorFromRGB(0x666666), for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        let rightBarButtomItem = UIBarButtonItem(customView: rightBtn)
        bar.barItem.rightBarButtonItem = rightBarButtomItem
        
        view.addSubview(avatarImg)
        avatarImg.snp.makeConstraints { (make) in
            make.top.equalTo(bar.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.height.equalTo(avatarImgHeight)
        }
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
    }
    
    @objc fileprivate func clickRightBtn() {
        let settingVC = SettingViewController()
        RootViewController.navigationController?.pushViewController(settingVC, animated: false)
    }
       
}
