//
//  PhotoPreviewsViewer.swift
//  Catinder
//
//  Created by Aleksey on 12.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoPreviewsViewer: UICollectionView {

	let itemHeight: CGFloat = 120
	private let layout = UICollectionViewFlowLayout()
	
	init() {
		super.init(frame: .zero, collectionViewLayout: layout)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		backgroundColor = .clear
		allowsMultipleSelection = false
		alwaysBounceHorizontal = true
		showsHorizontalScrollIndicator = false

		register(PhotoPreviewCell.self, forCellWithReuseIdentifier: "PhotoPreviewCell")

		layout.itemSize = CGSize(width: itemHeight * 0.8, height: itemHeight)
		layout.scrollDirection = .horizontal
	}
	
	func selectItem(at index: Int) {
		let indexPath = IndexPath(item: index, section: 0)
		selectItem(at: indexPath, animated: false, scrollPosition: .left)
	}
}
