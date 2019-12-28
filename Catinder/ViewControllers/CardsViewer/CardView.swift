//
//  CardView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardView: UIView {
	struct ViewModel {
		let imageName: String
		let informationText: String
	}
	
	private let imageView = UIImageView()
	private let informationLabel = UILabel()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(model: ViewModel) {
		super.init(frame: .zero)
		
		setupImageView()
		setupImformationLabel()
		updateUI(using: model)
	}
	
	private func setupImageView() {
		addSubview(imageView)
		imageView.constraintToSuperview()
		
		imageView.contentMode = .scaleAspectFill
	}
	
	private func setupImformationLabel() {
		addSubview(informationLabel)
		informationLabel.constraintToSuperview(edges: [.leading, .bottom])
		
		informationLabel.numberOfLines = 0
		informationLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		informationLabel.textColor = .white
		informationLabel.shadowColor = UIColor.init(white: 0.5, alpha: 0.5)
		informationLabel.shadowOffset = CGSize(width: 1, height: 1)
	}
	
	private func updateUI(using model: ViewModel) {
		imageView.image = UIImage(named: model.imageName)
		informationLabel.text = model.informationText
	}
}
