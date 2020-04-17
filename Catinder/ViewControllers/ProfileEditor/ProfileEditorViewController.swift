//
//  ProfileEditorViewController.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorViewController: UITableViewController {
	// MARK: - Sections
	
	private enum Section: String {
		case photos = "Фотографии"
		case name = "Имя"
		case age = "Возраст"
		case description = "Описание"
		
		var title: String {
			return rawValue
		}
		
		var placeholder: String {
			switch self {
			case .name:
				return "Как вас зовут"
			case .age:
				return "Сколько вам лет"
			case .description:
				return "Расскажите кратко о себе"
			default:
				return ""
			}
		}
	}
	
	
	// MARK: - Properties
	
	private let dataManager: DataManager
	private var userProfile: Profile?
	private let sections: [Section] = [.photos, .name, .age, .description]
	private let photoSelectorViewController = ProfilePhotoSelectorViewController()
	
	
	// MARK: - Init
	
	init(dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		super.init(style: .grouped)
		
		setupNavigationBar()
		setupTableView()
		setupGestures()
		loadData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = "Профиль"
	}
	
	private func setupTableView() {
		tableView.allowsSelection = false
		tableView.keyboardDismissMode = .onDrag
		tableView.contentInset.top = 20
	}
	
	private func setupGestures() {
		// hide keyboard on tap
		let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tapGestureRecognizer.cancelsTouchesInView = false
		tableView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	
	// MARK: - Load data
	
	private func loadData() {
		userProfile = AuthenticationManager.shared.loggedInUser
	}
}


// MARK: - UITableViewDataSource

extension ProfileEditorViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		sections.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		sections[section] == .photos ? 0 : 1
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		sections[section].title
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let placeholder = sections[indexPath.section].placeholder
		return ProfileEditorFieldTableViewCell(placeholder: placeholder)
	}
}


// MARK: - UITableViewDelegate

extension ProfileEditorViewController {
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		switch sections[section] {
		case .photos:
			addChild(photoSelectorViewController)
			return photoSelectorViewController.view

		default:
			return nil
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

		switch sections[section] {
		case .photos:
			photoSelectorViewController.collectionView.layoutIfNeeded()
			return photoSelectorViewController.collectionView.contentSize.height

		default:
			return UITableView.automaticDimension
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard let headerView = view as? UITableViewHeaderFooterView else { return }

		headerView.textLabel?.capitalizeText()
		headerView.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
	}
}
