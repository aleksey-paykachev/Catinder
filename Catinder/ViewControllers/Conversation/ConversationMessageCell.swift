//
//  ConversationMessageCell.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ConversationMessageCell: UICollectionViewCell {
	// MARK: - Properties
	
	private let messageLabel = UILabel(allowMultipleLines: true)
	var viewModel: ConversationMessageViewModel? { didSet { updateUI() } }
	
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	// MARK: - Setup
	
	private func setupView() {
		backgroundColor = .red
		messageLabel.backgroundColor = .yellow
		
		addSubview(messageLabel)
		messageLabel.constrainToSuperview(anchors: [.leading, .top, .bottom], paddings: .all(8), respectSafeArea: false)
		messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		messageLabel.text = viewModel?.message
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		messageLabel.text = ""
	}
}
