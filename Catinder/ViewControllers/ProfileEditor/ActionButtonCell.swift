//
//  ActionButtonCell.swift
//  Catinder
//
//  Created by Aleksey on 12.06.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ActionButtonCell: UITableViewCell {
	enum ButtonType {
		case regular
		case destructive
	}
	
	private let title: String
	private let type: ButtonType
	private let action: () -> ()
	
	init(title: String, type: ButtonType = .regular, action: @escaping () -> ()) {
		self.title = title
		self.type = type
		self.action = action
		
		super.init(style: .default, reuseIdentifier: nil)
		
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupButton() {
		let button = UIButton(type: .system)
		button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)

		button.setTitle(title, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
		if type == .destructive {
			button.setTitleColor(.systemRed, for: .normal)
		}

		// layout button
		addSubview(button)
		button.constrainToSuperview(anchors: [.leading, .top, .bottom], paddings: .all(12))
	}
	
	@objc func buttonDidTapped() {
		action()
	}
}
