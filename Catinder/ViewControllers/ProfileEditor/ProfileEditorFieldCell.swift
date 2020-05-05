//
//  ProfileEditorFieldCell.swift
//  Catinder
//
//  Created by Aleksey on 08/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorFieldCell: UITableViewCell {
	
	init(text: String? = nil, placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
		super.init(style: .default, reuseIdentifier: nil)
		
		let textField = UITextField()
		textField.text = text
		textField.placeholder = placeholder
		textField.keyboardType = keyboardType
		textField.autocorrectionType = .no
		contentView.addSubview(textField)
		textField.constrainToSuperview(paddings: .all(12), respectSafeArea: false)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
