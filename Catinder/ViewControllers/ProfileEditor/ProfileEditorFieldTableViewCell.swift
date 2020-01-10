//
//  ProfileEditorFieldTableViewCell.swift
//  Catinder
//
//  Created by Aleksey on 08/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorFieldTableViewCell: UITableViewCell {
	
	//	enum KeyboardType {
	//		case text
	//		case numbers
	//	}
	
	init(placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
		super.init(style: .default, reuseIdentifier: nil)
		
		let textField = UITextField()
		textField.placeholder = placeholder
		textField.keyboardType = keyboardType
		contentView.addSubview(textField)
		textField.constraintToSuperview(allEdgesInset: 12)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
