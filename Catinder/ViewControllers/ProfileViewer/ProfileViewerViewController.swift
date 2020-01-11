//
//  ProfileViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 10/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileViewerViewController: UIViewController {
	
	private let photoImageView = UIImageView()
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
		// photo
		photoImageView.contentMode = .scaleAspectFill
		photoImageView.clipsToBounds = true
		view.addSubview(photoImageView)
		photoImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
		
		// text labels
		setupTextLabels()
		
		// back button
		let backButton = UIButton(type: .custom)
		backButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
		view.addSubview(backButton)
		backButton.backgroundColor = .red

		backButton.centerYAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
		backButton.constraintToSuperview(edges: [.trailing], allEdgesInset: 36)
	}
	
	private func setupTextLabels() {
		// name
		nameLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		
		// description
		descriptionLabel.numberOfLines = 0
		descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		
		// stack view
		let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 12
		
		view.addSubview(stackView)
		stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 14).isActive = true
		stackView.constraintToSuperview(edges: [.leading, .trailing], allEdgesInset: 14)
	}
	
	@objc private func closeButtonDidTapped() {
		dismiss(animated: true, completion: nil)
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		photoImageView.image = viewModel.activePhotoName.flatMap { UIImage(named: $0) }
		nameLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
	}
}
