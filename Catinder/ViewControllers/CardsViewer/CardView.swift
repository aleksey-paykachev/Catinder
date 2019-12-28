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
		
		setupView()
		updateUI(using: model)
	}
	
	private func setupView() {
		layer.zPosition = 1 // place CardView above all other views
		
		setupGestures()
		
		setupImageView()
		setupImformationLabel()
	}
	
	private func setupGestures() {
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
		addGestureRecognizer(panGestureRecognizer)
	}
	
	@objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .began, .changed:
			let coordinate = gesture.translation(in: self)
			transform = CGAffineTransform(translationX: coordinate.x, y: coordinate.y)
			print(coordinate.x)

		case .ended, .cancelled, .failed:
			UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
				self?.transform = .identity
			}, completion: nil)
			print("The End")

		default:
			break
		}
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
