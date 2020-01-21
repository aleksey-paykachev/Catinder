//
//  ProfileEditorViewController.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorViewController: UITableViewController {
	
	private let dataManager: DataManager
	private var userProfile: CatProfile?
	
	init(dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		super.init(style: .grouped)
		
		setupNavigation()
		setupTableView()
		setupGestures()
		loadUserProfile()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupNavigation() {
		title = "Профиль"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
	}
	
	@objc private func handleDoneButton() {
		dismiss(animated: true)
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
	
	private func loadUserProfile() {
		dataManager.getProfile(by: "Logged-In-User-Profile-Id") { profile, error in
			if let error = error {
				print(error)
				return
			}
			
			userProfile = profile as? CatProfile
		}
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

extension ProfileEditorViewController {
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
		return ProfileEditorFieldTableViewCell(placeholder: placeholder)
	}
}


// MARK: - UITableViewDelegate

extension ProfileEditorViewController {
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let section = Section(id: section) else { return nil }

		if section == .photos {
			let photosSelectorViewController = PhotosSelectorViewController()
			addChild(photosSelectorViewController)

			return photosSelectorViewController.view
		}
		
		return nil
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		guard let section = Section(id: section) else { return 0 }

		return section == .photos ? 300 : UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard let headerView = view as? UITableViewHeaderFooterView else { return }

		headerView.textLabel?.capitalizeText()
		headerView.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
	}
}
