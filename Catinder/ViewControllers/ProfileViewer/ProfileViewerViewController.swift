//
//  ProfileViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 10/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileViewerViewController: UIViewController {
	
	private let scrollView = UIScrollView()
	private let photoImageView = UIImageView()
	private let nameLabel = UILabel(font: .systemFont(ofSize: 36, weight: .medium))
	private let descriptionLabel = UILabel(allowMultipleLines: true, font: .systemFont(ofSize: 18, weight: .regular))
	
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
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	private func setupView() {
		view.backgroundColor = .white
	}
	
	private func setupSubviews() {
		// scroll view
		scrollView.contentInsetAdjustmentBehavior = .never // don't use safeAreaInsets
		scrollView.alwaysBounceVertical = true
		view.addSubview(scrollView)
		scrollView.constrainToSuperview(respectSafeArea: false)
		
		// photo
		photoImageView.contentMode = .scaleAspectFill
		photoImageView.clipsToBounds = true
		photoImageView.constrainHeight(to: view.frame.width * 1.2)
		
		// text labels
		let textLabelsStack = VStackView([nameLabel, descriptionLabel], spacing: 12)
		
		// main stack
		let mainStackView = VStackView([photoImageView, textLabelsStack], spacing: 16)
		mainStackView.alignment = .center
		textLabelsStack.constrainToSuperview(anchors: [.leading, .trailing], paddings: .all(14))

		scrollView.addSubview(mainStackView)
		mainStackView.constrainToSuperview(paddings: .bottom(18), respectSafeArea: false)
		mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		
		// back button
		#warning("Add real asset image to backButton.")
		let backButton = UIButton(type: .system)
		backButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
		scrollView.addSubview(backButton)
		backButton.backgroundColor = .red

		backButton.centerYAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
		backButton.constrainToSuperview(anchors: [.trailing], paddings: .all(36))
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
