//
//  LoginScreenViewController.swift
//  Catinder
//
//  Created by Aleksey on 14.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
	
	private let loginTextField = UITextField()
	private let passwordTextField = UITextField()
	private var mainStack: VStackView!
	private var mainStackCenterYConstraint: NSLayoutConstraint!
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupView()
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		// demo version helper notification message
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
			self.showError("В данной демонстрационной версии вы можете ввести любое имя пользователя и пароль.", hideAfter: 6)
		}
	}
	
	private func setupView() {
		view.backgroundColor = .background

		// hide keyboard on tap
		let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tapGesture)
	}
	
	private func setupSubviews() {
		// logo
		guard let logoImage = UIImage(named: "CatinderLogo") else { return }
		let logoImageView = UIImageView(image: logoImage)
		logoImageView.contentMode = .scaleAspectFit

		let aspectRatio = logoImage.size.width / logoImage.size.height
		logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: aspectRatio).isActive = true
		
		// login textfield
		loginTextField.borderStyle = .roundedRect
		loginTextField.placeholder = "Имя пользователя"
		loginTextField.constrainHeight(to: 36)
		
		// password textfield
		passwordTextField.isSecureTextEntry = true
		passwordTextField.borderStyle = .roundedRect
		passwordTextField.placeholder = "Пароль"
		passwordTextField.constrainHeight(to: 36)
		
		// enter button
		let enterButton = CatinderPrimaryTextButton(text: "Войти")
		enterButton.addTarget(self, action: #selector(enterButtonDidTapped), for: .touchUpInside)
		enterButton.constrainHeight(to: 46)
		
		// main stack
		mainStack = VStackView([logoImageView, loginTextField, passwordTextField, enterButton], spacing: 8)
		mainStack.setCustomSpacing(60, after: logoImageView)
		mainStack.setCustomSpacing(20, after: passwordTextField)
		
		view.addSubview(mainStack)
		mainStack.constrainToSuperview(anchors: .centerX)
		mainStackCenterYConstraint = mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		mainStackCenterYConstraint.isActive = true
		mainStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
	}
	
	@objc private func enterButtonDidTapped() {
		guard let login = loginTextField.text, let password = passwordTextField.text else { return }
		
		// try to login
		showActivityIndicator()
		AuthenticationManager.shared.login(with: login, password: password) { [weak self] result in
			guard let self = self else { return }
			self.hideActivityIndicator()
			
			switch result {
			case .success:
				let mainViewController = CatinderNavigationController(rootViewController: CardsViewerViewController())
				mainViewController.modalPresentationStyle = .fullScreen
				self.present(mainViewController, animated: true)

			case .failure(let error):
				self.showError(error.localizedDescription)
			}
		}
	}
}


// MARK: - Keyboard handling

extension LoginScreenViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// add keyboard notification observers
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		// remove keyboard notification observers
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func handleKeyboardWillShow(notification: Notification) {
		// Check if keyboard overlaps content, and apply y-offset if so.
		guard let keyboardInfo = KeyboardNotificationInfo(of: notification) else { return }
		
		let keyboardContentOverlapHeight = mainStack.frame.maxY - keyboardInfo.frame.minY
		let paddingFromContentToKeyboard: CGFloat = 12
		
		if keyboardContentOverlapHeight > 0 {
			setContentYOffset(-keyboardContentOverlapHeight - paddingFromContentToKeyboard, with: keyboardInfo.animationDuration)
		}
	}
	
	@objc private func handleKeyboardWillHide(notification: Notification) {
		guard let keyboardInfo = KeyboardNotificationInfo(of: notification) else { return }

		setContentYOffset(0, with: keyboardInfo.animationDuration)
	}
	
	private func setContentYOffset(_ offsetY: CGFloat, with animationDuration: TimeInterval) {
		mainStackCenterYConstraint.constant = offsetY
		UIView.animate(withDuration: animationDuration) {
			self.view.layoutIfNeeded()
		}
	}
}
