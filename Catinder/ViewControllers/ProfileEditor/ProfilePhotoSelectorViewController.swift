//
//  ProfilePhotoSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorViewController: UICollectionViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
	}

	private func setupCollectionView() {
		collectionView.backgroundColor = .clear
		collectionView.register(ProfilePhotoSelectorCell.self, forCellWithReuseIdentifier: "ProfilePhotoSelector")
		(collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 100, height: 100)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		6
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoSelector", for: indexPath)
		//		cell.backgroundColor = .red
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		print("Move")
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath)
		let photoImagePicker = PhotoImagePicker()
		photoImagePicker.photoId = 1
		present(photoImagePicker, animated: true)
	}
	
	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		print("zzzz")
	}
}

class ProfilePhotoSelectorCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 10
		contentView.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).cgColor
		contentView.layer.borderWidth = 1
		contentView.clipsToBounds = true
//		imageView?.contentMode = .scaleAspectFill
	}
}
