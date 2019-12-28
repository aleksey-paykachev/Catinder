//
//  CardsViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardsViewerViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let subviews = [TopMenuView(), CardView(), BottomMenuView()]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical

		// layout
		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}
