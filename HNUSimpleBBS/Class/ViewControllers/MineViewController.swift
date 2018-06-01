//
//  MineViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let avatarImgHeight: CGFloat = 120

class MineViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var data: UserModel? {
        didSet {
            if data!.isUserLocalImage, let image = data!.localImage {
                avatarImg.image = image
            } else {
                avatarImg.kf.setImage(with: URL(string: data!.userAvatarUrl))
            }
            userNameLabel.text = data!.userName
        }
    }
    
    var avatarImg: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "icon_avatarImg"))
        avatar.layer.cornerRadius = avatarImgHeight/2
        avatar.layer.masksToBounds = true
        avatar.contentScaleFactor = BBSScreenScale
        avatar.contentMode = .scaleAspectFill
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "没有昵称哦"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
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
    
    // MARK: PrivateMethods
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
        
        let imgGesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap))
        avatarImg.addGestureRecognizer(imgGesture)
        
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleNameTap))
        userNameLabel.addGestureRecognizer(nameTapGesture)
        
        view.addSubview(avatarImg)
        avatarImg.snp.makeConstraints { (make) in
            make.top.equalTo(bar.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.height.equalTo(avatarImgHeight)
        }
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
//        let topView = UIToolbar(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: 30))
//        topView.barStyle = .default
//        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneButton = UIBarButtonItem(title: "完成修改", style: .done, target: self, action: #selector(dismissKeyBoard))
//        topView.items = [btnSpace, doneButton]
//        userNameLabel.inputAccessoryView = topView
    }
    
    fileprivate func checkNameLegal(name: String) -> Bool {
        if name == "" {
            return false
        }
        return true
    }
    
    // MARK: Action
    @objc fileprivate func clickRightBtn() {
        let settingVC = SettingViewController()
        RootViewController.navigationController?.pushViewController(settingVC, animated: false)
    }
    
    @objc fileprivate func handleAvatarTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "从手机相册选择", style: .default, handler: { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleNameTap() {
        let nameChangeView = MineNameInputView()
        nameChangeView.nameInputView.text = data?.userName
        nameChangeView.nameChangeSuccesClosure = { (name) in
            self.userNameLabel.text = name
            LoginModuel.shared.userInfo.userName = name
        }
        nameChangeView.show()
//        iToast.makeText("长按才可以修改昵称哦~").show()
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // UIImagePickerControllerEditedImage，获取的是编辑过的图片，UIImagePickerControllerOriginalImage 则获取原图
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        avatarImg.image = image
        LoginModuel.shared.userInfo.isUserLocalImage = true
        LoginModuel.shared.userInfo.localImage = image
        dismiss(animated: true, completion: nil)
    }
}
