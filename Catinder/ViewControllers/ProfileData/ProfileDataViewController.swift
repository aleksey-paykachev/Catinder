//
//  ProfileDataViewController.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileDataViewController: UITableViewController {
	
	let userProfile = CatProfile(name: "Боб", age: 10, breed: .unknown, photosNames: ["Cat_Bob_1", "Cat_Bob_2", "Cat_Bob_3"], description: "Про меня сняли фильм, и написали несколько книг. А чего добился ты?")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Profile Data"
	}
	
	#warning("Refactor to separate custom UIButton class")
	private func createImageButton() -> UIButton {
		let imageButton = UIButton()
		imageButton.backgroundColor = .lightGray
		imageButton.layer.cornerRadius = 10
		imageButton.clipsToBounds = true
		imageButton.setTitleColor(.black, for: .normal)
		imageButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		imageButton.setTitle("Select photo", for: .normal)
		
		let image = UIImage(named: userProfile.photosNames[1])
		imageButton.setImage(image, for: .normal)
		imageButton.imageView?.contentMode = .scaleAspectFill

		return imageButton
	}
}


// MARK: - UITableViewDataSource

extension ProfileDataViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
}


// MARK: - UITableViewDelegate

extension ProfileDataViewController {
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = UIView()
		let photosInterItemSpacing: CGFloat = 10
		let photosEdgePadding: CGFloat = 10
		
		let primaryImageButton = createImageButton()
		let secondaryImageButton1 = createImageButton()
		let secondaryImageButton2 = createImageButton()
		
		// two secondary photos on the right side
		let secondaryStackView = UIStackView(arrangedSubviews: [secondaryImageButton1, secondaryImageButton2])
		secondaryStackView.axis = .vertical
		secondaryStackView.distribution = .fillEqually
		secondaryStackView.spacing = photosInterItemSpacing
		
		// main photo on the left side
		let mainStackView = UIStackView(arrangedSubviews: [primaryImageButton, secondaryStackView])
		mainStackView.axis = .horizontal
		mainStackView.distribution = .fillEqually
		mainStackView.spacing = photosInterItemSpacing
		
		header.addSubview(mainStackView)
		mainStackView.constraintToSuperview(insets: UIEdgeInsets(top: photosEdgePadding, left: photosEdgePadding, bottom: photosEdgePadding, right: photosEdgePadding))
		
		return header
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 300
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
