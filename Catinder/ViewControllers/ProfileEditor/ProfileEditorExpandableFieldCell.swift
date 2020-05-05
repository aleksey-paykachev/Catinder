//
//  ProfileEditorExpandableFieldCell.swift
//  Catinder
//
//  Created by Aleksey on 05.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol ProfileEditorExpandableFieldCellDelegate: class {
	func textViewDidChanged()
}

class ProfileEditorExpandableFieldCell: UITableViewCell {
	
	weak var delegate: ProfileEditorExpandableFieldCellDelegate?

	private let textView = UITextView()
	private var placeholder: String?
	private let placeholderLabel = UILabel()

	init(text: String? = nil, placeholder: String? = nil, delegate: ProfileEditorExpandableFieldCellDelegate? = nil) {
		super.init(style: .default, reuseIdentifier: nil)
		
		self.placeholder = placeholder
		self.delegate = delegate
		
		textView.text = text
		textView.font = .systemFont(ofSize: 16)
		textView.backgroundColor = .clear
		textView.autocorrectionType = .no

		textView.isScrollEnabled = false
		textView.textContainerInset = .zero
		textView.textContainer.lineFragmentPadding = 0
		textView.delegate = self

		contentView.addSubview(textView)
		textView.constrainToSuperview(paddings: .all(12), respectSafeArea: false)
		
		setupPlaceholder()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupPlaceholder() {
		placeholderLabel.textColor = .placeholderText
		
		textView.addSubview(placeholderLabel)
		placeholderLabel.frame.origin = CGPoint(x: textView.textContainer.lineFragmentPadding,
												y: textView.textContainerInset.top)
		placeholderLabel.text = placeholder
		placeholderLabel.sizeToFit()

		updatePlaceholderVisibility()
	}
	
	private func updatePlaceholderVisibility() {
		placeholderLabel.isHidden = placeholder == nil || textView.text.isNotEmpty
	}
}


// MARK: - UITextViewDelegate

extension ProfileEditorExpandableFieldCell: UITextViewDelegate {

	func textViewDidChange(_ textView: UITextView) {
		updatePlaceholderVisibility()
		delegate?.textViewDidChanged()
	}
}
