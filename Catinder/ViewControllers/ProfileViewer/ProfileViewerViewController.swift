//
//  ProfileViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 10/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileViewerViewController: UIViewController {
	
	private let scrollView = UIScrollView()
	private let photoImageView = UIImageView()
	private let nameLabel = UILabel(font: .systemFont(ofSize: 36, weight: .medium))
	private let descriptionLabel = UILabel(allowMultipleLines: true, font: .systemFont(ofSize: 18, weight: .regular))
	private let photoPreviewsViewer = PhotoPreviewsViewer()
	
	private var viewModel: ProfileViewModel { didSet { updateUI() } }
	
	
	// MARK: - Init
	
	init(viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		setupView()
		setupSubviews()
		updateUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	private func setupView() {
		view.backgroundColor = .background
	}
	
	private func setupSubviews() {
		// scroll view
		scrollView.alwaysBounceVertical = true
		view.addSubview(scrollView)
		scrollView.constrainToSuperview()
		
		// photo
		photoImageView.contentMode = .scaleAspectFill
		photoImageView.clipsToBounds = true
		photoImageView.constrainHeight(to: view.frame.width * 1.5)
		
		// text labels
		let textLabelsStack = VStackView([nameLabel, descriptionLabel], spacing: 12)
		
		// main stack
		let mainStackView = VStackView([photoImageView, textLabelsStack], spacing: 16)
		mainStackView.alignment = .center
		textLabelsStack.constrainToSuperview(anchors: [.leading, .trailing], paddings: .all(16))

		scrollView.addSubview(mainStackView)
		mainStackView.constrainToSuperview(paddings: .bottom(24), respectSafeArea: false)
		mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		
		// photo previews
		setupPhotoPreviewsViewer()
		
		// close button
		let closeButton = UIButton()
		closeButton.setImage(UIImage(named: "Dismiss"), for: .normal)
		closeButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)

		view.addSubview(closeButton)
		closeButton.constrainSize(to: .square(44))
		closeButton.centerYAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
		closeButton.constrainToSuperview(anchors: [.trailing], paddings: .all(30))
	}
	
	private func setupPhotoPreviewsViewer() {
		// do not show photo previews viewer if user has only one photo
		guard viewModel.photosCount > 1 else { return }

		photoPreviewsViewer.dataSource = self
		photoPreviewsViewer.delegate = self
		
		view.addSubview(photoPreviewsViewer)
		photoPreviewsViewer.constrainHeight(to: photoPreviewsViewer.itemHeight)
		photoPreviewsViewer.constrainTo(photoImageView, anchors: [.leading, .trailing, .bottom], paddings: .all(12))
		
		photoPreviewsViewer.selectItem(at: viewModel.selectedPhotoIndex)
	}
	
	@objc private func closeButtonDidTapped() {
		dismiss(animated: true, completion: nil)
	}
	
	
	// MARK: - UI
	
	private func updateUI() {
		updateSelectedImage()
		nameLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
	}
	
	private func updateSelectedImage() {
		guard let imageName = viewModel.selectedPhotoName else { return }

		DataManager.shared.getImage(name: imageName) { [weak self] image, _ in
			self?.photoImageView.image = image
		}
	}
}


// MARK: - data source for PhotoPreviewsViewer

extension ProfileViewerViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.photosCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueCell(PhotoPreviewCell.self, for: indexPath)

		// download image from server
		let imageName = viewModel.photosNames[indexPath.item]
		cell.showActivityIndicator()

		DataManager.shared.getImage(name: imageName) { [weak cell] image, _ in
			cell?.set(image: image)
		}

		return cell
	}
}


// MARK: - delegate for PhotoPreviewsViewer

extension ProfileViewerViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.setPhotoAsSelected(at: indexPath.item)
		updateSelectedImage()
	}
}
