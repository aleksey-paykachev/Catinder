//
//  LastMessageCell.swift
//  Catinder
//
//  Created by Aleksey on 22/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class LastMessageCell: UICollectionViewCell {
	let profileImageView = UIImageView()
	let profileNameLabel = UILabel(font: .systemFont(ofSize: 18, weight: .medium))
	let messageTextView = UITextView()
	private var downloadingImageName: String?
	
	var viewModel: LastMessageViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			updateUI(with: viewModel)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		setupView(with: frame.size)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView(with size: CGSize) {
		// profile image
		profileImageView.contentMode = .scaleAspectFill
		profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
		profileImageView.layer.setCorner(radius: size.height / 2)
		profileImageView.layer.setBorder(size: 2, color: .lastMessagesProfileBorder)
		
		// profile name
		profileNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		
		// message
		messageTextView.isScrollEnabled = false
		messageTextView.isEditable = false
		messageTextView.isUserInteractionEnabled = false
		messageTextView.font = .systemFont(ofSize: 16)
		messageTextView.textColor = .secondaryLabel
		messageTextView.textContainerInset = .zero
		messageTextView.textContainer.lineFragmentPadding = 0
		
		// distribute all subviews in two stacks
		let textStack = VStackView([profileNameLabel, messageTextView], spacing: 4)
		let mainStack = HStackView([profileImageView, textStack], spacing: 14)
		
		addSubview(mainStack)
		mainStack.constrainToSuperview(respectSafeArea: false)
	}
	
	private func updateUI(with viewModel: LastMessageViewModel) {
		let imageName = viewModel.profileImageName
		downloadingImageName = imageName

		DataManager.shared.getImage(name: imageName) { [weak self] image, _ in
			guard self?.downloadingImageName == imageName else { return }
			
			self?.profileImageView.image = image
		}

		profileNameLabel.text = viewModel.profileName
		messageTextView.text = viewModel.message
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()

		downloadingImageName = nil
		
		profileImageView.image = nil
		profileNameLabel.text = ""
		messageTextView.text = ""
	}
}
