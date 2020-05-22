//
//  ConversationTextInputView.swift
//  Catinder
//
//  Created by Aleksey on 01.02.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol ConversationTextInputViewDelegate: class {
	func sendButtonDidTapped(with text: String)
}

class ConversationTextInputView: UIView {
	// MARK: - Properties
	
	private let textInputTextView = UITextView()
	private lazy var sendButton = CatinderImageButton("SendMessage") { [weak self] in
		self?.sendButtonDidTapped()
	}
	weak var delegate: ConversationTextInputViewDelegate?

	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		
		setupView()
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		backgroundColor = .conversationTextInputViewBackground
		layer.setShadow(size: 1, offsetY: -1, alpha: 0.1)
	}
	
	private func setupSubviews() {
		// text view
		textInputTextView.font = .systemFont(ofSize: 15)
		textInputTextView.backgroundColor = .conversationTextFieldBackground
		textInputTextView.delegate = self
		textInputTextView.isScrollEnabled = false
		textInputTextView.clipsToBounds = false
		textInputTextView.layer.setShadow(size: 2, alpha: 0.2)

		// send button
		sendButton.isEnabled = false
		sendButton.constrainSize(to: .square(28))
		sendButton.tintColor = .conversationSendButton
		
		// stack
		let stack = HStackView([textInputTextView, sendButton], spacing: 10)
		stack.alignment = .center
		addSubview(stack)
		stack.constrainToSuperview(paddings: .all(10), respectSafeArea: false)
	}
	
	private func sendButtonDidTapped() {
		guard let text = textInputTextView.text?.trimmed, text.isNotEmpty else { return }

		textInputTextView.text = ""
		sendButton.isEnabled = false
		delegate?.sendButtonDidTapped(with: text)
	}
}


// MARK: - UITextViewDelegate

extension ConversationTextInputView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		sendButton.isEnabled = textView.text.trimmed.isNotEmpty
	}
}
