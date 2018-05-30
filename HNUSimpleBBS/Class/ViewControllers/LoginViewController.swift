//
//  LoginViewController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

private let buttonFrame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
private let buttonHeight = textFieldHeight
private let buttonHorizontalMargin = textFieldHorizontalMargin / 2
private let buttonImageDimension: CGFloat = 18
private let buttonVerticalMargin = (buttonHeight - buttonImageDimension) / 2
private let buttonWidth = (textFieldHorizontalMargin / 2) + buttonImageDimension
private let critterViewDimension: CGFloat = 160
private let critterViewFrame = CGRect(x: 0, y: 0, width: critterViewDimension, height: critterViewDimension)
private let critterViewTopMargin: CGFloat = 70
private let textFieldHeight: CGFloat = 37
private let textFieldHorizontalMargin: CGFloat = 16.5
private let textFieldSpacing: CGFloat = 22
private let textFieldTopMargin: CGFloat = 38.8
private let textFieldWidth: CGFloat = 206

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginSuccessClosure: ((_ userInfo: BaseModel) -> ())? = nil
    var loginFailClosure: (() -> ())? = nil
    fileprivate var account: String = ""
    fileprivate var password: String = ""
    var userInfo: BaseModel = BaseModel()

    private let critterView = CritterView(frame: critterViewFrame)

    private lazy var accoutTextField: UITextField = {
        let textField = createTextField(text: "Accout")
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = createTextField(text: "Password")
        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        textField.rightView = showHidePasswordButton
        showHidePasswordButton.isHidden = true
        return textField
    }()

    private lazy var showHidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: buttonVerticalMargin, left: 0, bottom: buttonVerticalMargin, right: buttonHorizontalMargin)
        button.frame = buttonFrame
        button.tintColor = .loginText
        button.setImage(#imageLiteral(resourceName: "Password-show"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "Password-hide"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        return button
    }()

    private let notificationCenter: NotificationCenter = .default

    deinit {
        notificationCenter.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let deadlineTime = DispatchTime.now() + .milliseconds(100)

        if textField == accoutTextField {
            if let str = textField.text {
                account = str
            }
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { // 🎩✨ Magic to ensure animation starts
                let fractionComplete = self.fractionComplete(for: textField)
                self.critterView.startHeadRotation(startAt: fractionComplete)
                self.passwordDidResignAsFirstResponder()
            }
        }
        else if textField == passwordTextField {
            if let str = textField.text {
                password = str
            }
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { // 🎩✨ Magic to ensure animation starts
                self.critterView.isShy = true
                self.showHidePasswordButton.isHidden = false
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accoutTextField {
            if let str = textField.text {
                account = str
            }
            passwordTextField.becomeFirstResponder()
        }
        else {
            if let str = textField.text {
                password = str
            }
            passwordTextField.resignFirstResponder()
            passwordDidResignAsFirstResponder()
            checkAccount_Password()
//            RootViewController.navigationController?.popViewController(animated: false)
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == accoutTextField {
            if let str = textField.text {
                account = str
            }
            critterView.stopHeadRotation()
        } else {
            if let str = textField.text {
                password = str
            }
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard !critterView.isActiveStartAnimating, textField == accoutTextField else {
            if let str = textField.text {
                password = str
            }
            return
        }

        let fractionComplete = self.fractionComplete(for: textField)
        critterView.updateHeadRotation(to: fractionComplete)

        if let text = textField.text {
            account = text
            critterView.isEcstatic = text.range(of: "@") != nil
            
            if text.count > 23 {
                let it = iToast.makeText("已超出最大字数限制")
                it.set(gravity: .center, offsetLeft: 0, offsetTop: -94)
                it.show()
                let index = text.index(text.startIndex, offsetBy: 23)
                textField.text = String(text[..<index])
                account = String(text[..<index])
            }
        }
    }

    // MARK: - Private

    private func setUpView() {
//        UIApplication.shared.statusBarView?.backgroundColor = .loginDark
        let bar: BBSNavigationBar = BBSNavigationBar().setTransparentStyle().place(at: self)
        bar.backgroundColor = .clear
        bar.barItem.titleView = {
            let label = UILabel()
            label.text = "登录"
            label.textColor = UIColorFromRGB(0x222222)
            label.font = UIFont.bbs_defaultFontWith(size: 18)
            label.sizeToFit()
            return label
        }()
        
        let button = TransitionButton()
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(100)
        }
        button.addTarget(self, action: #selector(handleClickLoginBtn(sender:)), for: .touchUpInside)
        button.backgroundColor = .loginLight
        button.setTitle("确定", for: .normal)
        button.titleLabel?.font = UIFont.bbs_defaultFontWith(size: 15)
        button.setTitleColor(UIColorFromRGB(0x333333), for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        
        
        view.backgroundColor = .loginDark

        view.addSubview(critterView)
        setUpCritterViewConstraints()

        view.addSubview(accoutTextField)
        setUpaccoutTextFieldConstraints()

        view.addSubview(passwordTextField)
        setUpPasswordTextFieldConstraints()

        setUpGestures()
        setUpNotification()

        debug_setUpDebugUI()
    }

    private func setUpCritterViewConstraints() {
        critterView.translatesAutoresizingMaskIntoConstraints = false
        critterView.heightAnchor.constraint(equalToConstant: critterViewDimension).isActive = true
        critterView.widthAnchor.constraint(equalTo: critterView.heightAnchor).isActive = true
        critterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        critterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: critterViewTopMargin).isActive = true
    }

    private func setUpaccoutTextFieldConstraints() {
        accoutTextField.translatesAutoresizingMaskIntoConstraints = false
        accoutTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        accoutTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        accoutTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accoutTextField.topAnchor.constraint(equalTo: critterView.bottomAnchor, constant: textFieldTopMargin).isActive = true
    }

    private func setUpPasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: accoutTextField.bottomAnchor, constant: textFieldSpacing).isActive = true
    }

    private func fractionComplete(for textField: UITextField) -> Float {
        guard let text = textField.text, let font = textField.font else { return 0 }
        let textFieldWidth = textField.bounds.width - (2 * textFieldHorizontalMargin)
        return min(Float(text.size(withAttributes: [NSAttributedStringKey.font : font]).width / textFieldWidth), 1)
    }

    private func stopHeadRotation() {
        accoutTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        critterView.stopHeadRotation()
        passwordDidResignAsFirstResponder()
    }

    private func passwordDidResignAsFirstResponder() {
        critterView.isPeeking = false
        critterView.isShy = false
        showHidePasswordButton.isHidden = true
        showHidePasswordButton.isSelected = false
        passwordTextField.isSecureTextEntry = true
    }

    private func createTextField(text: String) -> UITextField {
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight))
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.07
        view.tintColor = .loginDark
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        view.delegate = self
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        let frame = CGRect(x: 0, y: 0, width: textFieldHorizontalMargin, height: textFieldHeight)
        view.leftView = UIView(frame: frame)
        view.leftViewMode = .always

        view.rightView = UIView(frame: frame)
        view.rightViewMode = .always

        view.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        view.textColor = .loginText

        let attributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor.loginDisabledText,
            .font : view.font!
        ]

        view.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)

        return view
    }

    // MARK: - Gestures

    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        stopHeadRotation()
    }

    // MARK: - Actions

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        let isPasswordVisible = !sender.isSelected
        sender.isSelected = isPasswordVisible
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        critterView.isPeeking = isPasswordVisible

        // 🎩✨ Magic to fix cursor position when toggling password visibility
        if let textRange = passwordTextField.textRange(from: passwordTextField.beginningOfDocument, to: passwordTextField.endOfDocument), let password = passwordTextField.text {
            passwordTextField.replace(textRange, withText: password)
        }
    }
    
    @objc func handleClickLoginBtn(sender: TransitionButton) {
        sender.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(1)
            
            DispatchQueue.main.async(execute: {
                sender.stopAnimation(animationStyle: .expand,
                                     revertAfterDelay: 2,
                                     completion: {
                                        self.checkAccount_Password()
                })
            })
        }
    }

    // MARK: Verify
    func checkAccount_Password() {
        if password == "123" {
            LoginModuel.shared.isLogin = true
            RootViewController.navigationController?.popViewController(animated: false)
            loginSuccessClosure?(userInfo)
            
        } else {
            iToast.makeText("密码输入错误哦🐷").show()
        }
    }
    
    // MARK: - Notifications

    private func setUpNotification() {
        notificationCenter.addObserver(self, selector: #selector(applicationDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
    }

    @objc private func applicationDidEnterBackground() {
        stopHeadRotation()
    }

    // MARK: - Debug Mode

    private let isDebugMode = false

    private lazy var dubug_activeAnimationSlider = UISlider()

    private func debug_setUpDebugUI() {
        guard isDebugMode else { return }

        let animateButton = UIButton(type: .system)
        animateButton.setTitle("Activate", for: .normal)
        animateButton.setTitleColor(.white, for: .normal)
        animateButton.addTarget(self, action: #selector(debug_activeAnimation), for: .touchUpInside)

        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Neutral", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.addTarget(self, action: #selector(debug_neutralAnimation), for: .touchUpInside)

        let validateButton = UIButton(type: .system)
        validateButton.setTitle("Ecstatic", for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
        validateButton.addTarget(self, action: #selector(debug_ecstaticAnimation), for: .touchUpInside)

        dubug_activeAnimationSlider.tintColor = .loginLight
        dubug_activeAnimationSlider.isEnabled = false
        dubug_activeAnimationSlider.addTarget(self, action: #selector(debug_activeAnimationSliderValueChanged(sender:)), for: .valueChanged)

        let stackView = UIStackView(
            arrangedSubviews:
            [
                animateButton,
                resetButton,
                validateButton,
                dubug_activeAnimationSlider
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 5
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc private func debug_activeAnimation() {
        critterView.startHeadRotation(startAt: dubug_activeAnimationSlider.value)
        dubug_activeAnimationSlider.isEnabled = true
    }

    @objc private func debug_neutralAnimation() {
        stopHeadRotation()
        dubug_activeAnimationSlider.isEnabled = false
    }

    @objc private func debug_ecstaticAnimation() {
        critterView.isEcstatic = !critterView.isEcstatic
    }

    @objc private func debug_activeAnimationSliderValueChanged(sender: UISlider) {
        critterView.updateHeadRotation(to: sender.value)
    }
}
