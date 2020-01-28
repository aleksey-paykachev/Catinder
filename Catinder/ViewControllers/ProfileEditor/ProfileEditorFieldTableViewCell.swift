//
//  ProfileEditorFieldTableViewCell.swift
//  Catinder
//
//  Created by Aleksey on 08/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorFieldTableViewCell: UITableViewCell {
	
	init(placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
		super.init(style: .default, reuseIdentifier: nil)
		
		let textField = UITextField()
		textField.placeholder = placeholder
		textField.keyboardType = keyboardType
		contentView.addSubview(textField)
		textField.constrainToSuperview(paddings: .all(12), respectSafeArea: false)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
