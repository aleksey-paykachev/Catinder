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
	
	init() {
		super.init(style: .grouped)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Профиль"

		setupTableView()
		setupGestures()
	}
	
	private func setupTableView() {
		tableView.allowsSelection = false
		tableView.keyboardDismissMode = .onDrag
	}
	
	private func setupGestures() {
		// hide keyboard on tap
		let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tapGestureRecognizer.cancelsTouchesInView = false
		tableView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	#warning("Refactor: move to separate class")
	private func createPhotosSelectorHeaderView() -> UIView {
		let header = UIView()
		let photosInterItemSpacing: CGFloat = 10
		let photosEdgePadding: CGFloat = 16
		
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
		mainStackView.constraintToSuperview(allEdgesInset: photosEdgePadding)
		
		return header
	}
	
	#warning("Refactor: move to separate custom UIButton class")
	private func createImageButton() -> UIButton {
		let imageButton = UIButton()
		imageButton.backgroundColor = .lightGray
		imageButton.layer.cornerRadius = 10
		imageButton.clipsToBounds = true
		imageButton.setTitleColor(.black, for: .normal)
		imageButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		imageButton.setTitle("Выберите фото", for: .normal)
		
		let image = UIImage(named: userProfile.photosNames[1])
		imageButton.setImage(image, for: .normal)
		imageButton.imageView?.contentMode = .scaleAspectFill

		return imageButton
	}
	
	private enum Section: Int, CaseIterable {
		case photos
		case name
		case age
		case description
		
		init?(id: RawValue) {
			self.init(rawValue: id)
		}
		
		static var sectionsCount: Int {
			return allCases.count
		}
		
		var title: String {
			switch self {
			case .photos:
				return "Фотографии"
			case .name:
				return "Имя"
			case .age:
				return "Возраст"
			case .description:
				return "Описание"
			}
		}
	}
}


// MARK: - UITableViewDataSource

extension ProfileDataViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		return Section.sectionsCount
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return Section(id: section) == .photos ? 0 : 1
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		return Section(id: section)?.title
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let placeholder = Section(id: indexPath.section)?.title
		return ProfileDataFieldTableViewCell(placeholder: placeholder)
	}
}


// MARK: - UITableViewDelegate

extension ProfileDataViewController {
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let section = Section(id: section) else { return nil }

		return section == .photos ? createPhotosSelectorHeaderView() : nil
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		guard let section = Section(id: section) else { return 0 }

		return section == .photos ? 300 : UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard let headerView = view as? UITableViewHeaderFooterView else { return }

		headerView.textLabel?.capitalizeText()
		headerView.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
	}
}
