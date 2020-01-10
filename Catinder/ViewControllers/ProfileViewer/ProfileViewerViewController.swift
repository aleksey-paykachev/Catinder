//
//  ProfileViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 10/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileViewerViewController: UIViewController {
	
	private let nameLabel = UILabel()
	private let descriptionLabel = UILabel()
	
	private var viewModel: ProfileViewModel { didSet { updateUI() } }
	
	
	// MARK: - Init
	
	init(viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		setupView()
		setupSubviews()
		updateUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup

	private func setupView() {
		view.backgroundColor = .white
	}
	
	private func setupSubviews() {
		
		// name
		
		// description
		descriptionLabel.numberOfLines = 0
		
		// stack view
		let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		
		view.addSubview(stackView)
		stackView.constraintToSuperview()
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		nameLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
	}
}
