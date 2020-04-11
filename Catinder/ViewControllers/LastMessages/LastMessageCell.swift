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
	
	var viewModel: LastMessageViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			
			profileImageView.image = UIImage(named: viewModel.profileImageName)
			profileNameLabel.text = viewModel.profileName
			messageTextView.text = viewModel.message
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
		profileImageView.layer.roundCorners(radius: size.height / 2)
		profileImageView.layer.setBorder(size: 2, color: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
		
		// profile name
		profileNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		
		// message
		messageTextView.isScrollEnabled = false
		messageTextView.isEditable = false
		messageTextView.isUserInteractionEnabled = false
		messageTextView.font = .systemFont(ofSize: 16)
		messageTextView.textColor = .darkGray
		messageTextView.textContainerInset = .zero
		messageTextView.textContainer.lineFragmentPadding = 0
		
		// distribute all subviews in two stacks
		let textStack = VStackView([profileNameLabel, messageTextView], spacing: 6, distribution: .fill)
		let mainStack = HStackView([profileImageView, textStack], spacing: 14, distribution: .fill)
		
		addSubview(mainStack)
		mainStack.constrainToSuperview(respectSafeArea: false)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		profileImageView.image = nil
		profileNameLabel.text = ""
		messageTextView.text = ""
	}
}
