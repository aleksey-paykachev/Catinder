//
//  LoginScreenViewController.swift
//  Catinder
//
//  Created by Aleksey on 14.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupView()
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		// hide keyboard on tap
		let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tapGesture)
	}
	
	private func setupSubviews() {
		view.backgroundColor = .background
		
		// logo
		guard let logoImage = UIImage(named: "CatinderLogo") else { return }
		let logoImageView = UIImageView(image: logoImage)
		logoImageView.contentMode = .scaleAspectFit

		let aspectRatio = logoImage.size.width / logoImage.size.height
		logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: aspectRatio).isActive = true
		
		// login textfield
		let loginTextField = UITextField()
		loginTextField.borderStyle = .roundedRect
		loginTextField.placeholder = "Имя пользователя"
		loginTextField.constrainHeight(to: 36)
		
		// password textfield
		let passwordTextField = UITextField()
		passwordTextField.isSecureTextEntry = true
		passwordTextField.borderStyle = .roundedRect
		passwordTextField.placeholder = "Пароль"
		passwordTextField.constrainHeight(to: 36)
		
		// enter button
		let enterButton = CatinderPrimaryTextButton(text: "Войти")
		enterButton.addTarget(self, action: #selector(enterButtonDidTapped), for: .touchUpInside)
		enterButton.constrainHeight(to: 44)
		
		// main stack
		let stack = VStackView([logoImageView, loginTextField, passwordTextField, enterButton], spacing: 8)
		stack.setCustomSpacing(60, after: logoImageView)
		stack.setCustomSpacing(20, after: passwordTextField)
		
		view.addSubview(stack)
		stack.constrainToSuperview(anchors: [.centerX, .centerY])
		stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
	}
	
	@objc private func enterButtonDidTapped() {
		showActivityIndicator()
		AuthenticationManager.shared.login(with: "login", password: "password") { [weak self] result in
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
