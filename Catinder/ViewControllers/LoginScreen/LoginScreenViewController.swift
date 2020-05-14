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
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		view.backgroundColor = .background
		
		let logoImageView = UIImageView(image: UIImage(named: "CatinderLogo"))
		logoImageView.contentMode = .scaleAspectFit
		
		let enterButton = CatinderPrimaryTextButton(text: "Войти")
		enterButton.addTarget(self, action: #selector(enterButtonDidTapped), for: .touchUpInside)
		enterButton.constrainHeight(to: 50)
		
		let stack = VStackView([logoImageView, enterButton], spacing: 24)
		
		view.addSubview(stack)
		stack.constrainToSuperview(anchors: [.centerX, .centerY])
		stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
	}
	
	@objc private func enterButtonDidTapped() {
		AuthenticationManager.shared.login(with: "login", password: "password")
		
		let cardViewerViewController = CardsViewerViewController()
		cardViewerViewController.modalPresentationStyle = .fullScreen
		present(cardViewerViewController, animated: true)
	}
}
