//
//  CatinderTextInputAccessoryView.swift
//  Catinder
//
//  Created by Aleksey on 01.02.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CatinderTextInputAccessoryViewDelegate: class {
	func sendButtonDidTapped(with text: String)
}

class CatinderTextInputAccessoryView: UIView {
	// MARK: - Properties
	
	private let textInputTextView = UITextView()
	private let sendButton = UIButton(type: .system)
	weak var delegate: CatinderTextInputAccessoryViewDelegate?

	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		
		setupView()
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - API
	
	func hideKeyboard() {
		textInputTextView.resignFirstResponder()
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		frame.size.height = 50
		backgroundColor = .white
		layer.setShadow(size: 1, offsetY: -1, alpha: 0.1)
	}
	
	private func setupSubviews() {
		// text view
		textInputTextView.delegate = self
		textInputTextView.isScrollEnabled = false
		textInputTextView.clipsToBounds = false
		textInputTextView.layer.setShadow(size: 2, alpha: 0.2)

		// send button
		sendButton.isEnabled = false
		sendButton.addTarget(self, action: #selector(sendButtonDidTapped), for: .touchUpInside)
		#warning("Add real send button image.")
		sendButton.setTitle(">", for: .normal)
		sendButton.constrainWidth(to: 20)
		
		// stack
		let stack = HStackView([textInputTextView, sendButton], spacing: 10)
		addSubview(stack)
		stack.constrainToSuperview(paddings: .all(10), respectSafeArea: false)
	}
	
	@objc private func sendButtonDidTapped() {
		guard let text = textInputTextView.text?.trimmed, text.isNotEmpty else { return }

		textInputTextView.text = ""
		sendButton.isEnabled = false
		delegate?.sendButtonDidTapped(with: text)
	}
}


// MARK: - UITextViewDelegate

extension CatinderTextInputAccessoryView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		sendButton.isEnabled = textView.text.trimmed.isNotEmpty
	}
}
