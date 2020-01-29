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
	
	private let messageView = UIView()
	private let messageLabel = UILabel(color: .darkText, allowMultipleLines: true, font: .systemFont(ofSize: 14))
	var viewModel: ConversationMessageViewModel? { didSet { updateUI() } }
	
	lazy var messageViewLeadingAnchor = messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
	lazy var messageViewTrailingAnchor = messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
	
	
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
		// message label
		messageView.addSubview(messageLabel)
		messageLabel.constrainToSuperview(paddings: .horizontal(14) + .vertical(10), respectSafeArea: false)

		// message view
		addSubview(messageView)
		messageView.constrainToSuperview(anchors: [.top, .bottom], respectSafeArea: false)
		messageView.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
		
		messageView.layer.roundCorners(radius: 10)
		messageViewLeadingAnchor.priority = .defaultLow // to prevent autolayout issues
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		guard let viewModel = viewModel else { return }

		messageLabel.text = viewModel.messageText
		
		switch viewModel.sender {
		case .user:
			messageView.backgroundColor = .cyan
			messageViewLeadingAnchor.isActive = false
			messageViewTrailingAnchor.isActive = true
		case .collocutor:
			messageView.backgroundColor = .white
			messageViewTrailingAnchor.isActive = false
			messageViewLeadingAnchor.isActive = true
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		messageLabel.text = ""
	}
}
