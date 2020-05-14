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
		let logoImageView = UIImageView(image: UIImage(named: "CatinderLogo"))
		logoImageView.contentMode = .scaleAspectFit
		
		// login textfield
		let loginTextField = UITextField()
		loginTextField.borderStyle = .roundedRect
		loginTextField.placeholder = "Login"
		loginTextField.constrainHeight(to: 36)
		
		// passwork textfield
		let passwordTextField = UITextField()
		passwordTextField.borderStyle = .roundedRect
		passwordTextField.placeholder = "Password"
		passwordTextField.constrainHeight(to: 36)
		
		// enter button
		let enterButton = CatinderPrimaryTextButton(text: "Войти")
		enterButton.addTarget(self, action: #selector(enterButtonDidTapped), for: .touchUpInside)
		enterButton.constrainHeight(to: 44)
		
		// main stack
		let stack = VStackView([logoImageView, loginTextField, passwordTextField, enterButton], spacing: 12)
		
		view.addSubview(stack)
		stack.constrainToSuperview(anchors: [.centerX, .centerY])
		stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
	}
	
	@objc private func enterButtonDidTapped() {
		AuthenticationManager.shared.login(with: "login", password: "password")
		
		let mainViewController = CatinderNavigationController(rootViewController: CardsViewerViewController())
		mainViewController.modalPresentationStyle = .fullScreen
		present(mainViewController, animated: true)
	}
}
