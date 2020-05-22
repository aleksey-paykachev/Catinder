//
//  ConversationMessageCell.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ConversationMessageCell: UITableViewCell {
	// MARK: - Properties
	
	private let messageViewHorizontalAlignmentPadding: CGFloat = 12
	
	private let messageView = UIView()
	private let messageLabel = UILabel(color: .conversationMessageText, allowMultipleLines: true, font: .systemFont(ofSize: 14))
	private let sendStatusMarkSignView = SendStatusMarkSignView()
	var viewModel: ConversationMessageViewModel? { didSet { updateUI() } }
	
	lazy var messageViewLeadingAnchor = messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: messageViewHorizontalAlignmentPadding)
	lazy var messageViewTrailingAnchor = messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -messageViewHorizontalAlignmentPadding)
	
	
	// MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupView()
		setupSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	// MARK: - Setup
	
	private func setupView() {
		backgroundColor = .clear
	}
	
	private func setupSubviews() {
		// message label
		messageView.addSubview(messageLabel)
		messageLabel.constrainToSuperview(paddings: .horizontal(14) + .vertical(10))
		
		// mark sign
		sendStatusMarkSignView.constrainSize(to: .square(9))
		messageView.addSubview(sendStatusMarkSignView)
		sendStatusMarkSignView.constrainToSuperview(anchors: [.trailing, .bottom], paddings: .all(5))

		// message view
		contentView.addSubview(messageView)
		messageView.constrainToSuperview(anchors: [.top, .bottom], paddings: .all(4))
		messageView.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
		
		messageView.layer.setCorner(radius: 10)
		messageView.layer.setBorder(size: 1, color: .conversationMessageBorder)
		messageViewLeadingAnchor.priority = .defaultLow // to prevent autolayout issues
	}
		
	private func setMessageViewAlignLeading() {
		messageViewTrailingAnchor.isActive = false
		messageViewLeadingAnchor.isActive = true
	}
	
	private func setMessageViewAlignTrailing() {
		messageViewLeadingAnchor.isActive = false
		messageViewTrailingAnchor.isActive = true
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		guard let viewModel = viewModel else { return }

		messageLabel.text = viewModel.messageText
		
		switch viewModel.sender {
		case .user:
			messageView.backgroundColor = .conversationUserMessageBackground
			setMessageViewAlignTrailing()

		case .collocutor:
			messageView.backgroundColor = .conversationCollocutorMessageBackground
			setMessageViewAlignLeading()
		}
		
		switch viewModel.status {
		case .notSended:
			sendStatusMarkSignView.hide()
		case .sended, .viewed:
			sendStatusMarkSignView.show()
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		messageLabel.text = ""
		sendStatusMarkSignView.hide()
	}
}
