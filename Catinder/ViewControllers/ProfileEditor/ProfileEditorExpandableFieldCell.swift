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
	
	init(text: String? = nil, placeholder: String? = nil, delegate: ProfileEditorExpandableFieldCellDelegate? = nil) {
		super.init(style: .default, reuseIdentifier: nil)
		
		self.delegate = delegate
		
		let textView = UITextView()
		textView.text = text
		textView.font = .systemFont(ofSize: 16)
		textView.autocorrectionType = .no

		textView.isScrollEnabled = false
		textView.textContainerInset = .zero
		textView.textContainer.lineFragmentPadding = 0
		textView.delegate = self

		contentView.addSubview(textView)
		textView.constrainToSuperview(paddings: .all(12), respectSafeArea: false)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


// MARK: - UITextViewDelegate

extension ProfileEditorExpandableFieldCell: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		delegate?.textViewDidChanged()
	}
}
