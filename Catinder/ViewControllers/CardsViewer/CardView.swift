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
		let titleText: String
		let subTitleText: String
	}
	
	private let imageView = UIImageView()
	private let subLabelsGradientLayer = CAGradientLayer()
	private let titleLabel = UILabel()
	private let subTitleLabel = UILabel()

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(model: ViewModel) {
		super.init(frame: .zero)
		
		setupView()
		updateUI(using: model)
	}
	
	private func setupView() {
		setupGestures()
		
		setupLayer()
		setupImageView()
		setupLabels()
	}
	
	private func setupLayer() {
		layer.zPosition = 1 // place CardView above all other views

		layer.cornerRadius = 14
		layer.masksToBounds = true
		
		layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
		layer.borderWidth = 1
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
	
	private func setupLabels() {
		addSubLabelsGradient() // add gradient behind the text to improve readability
		
		// put all labels inside one stack
		let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
		labelsStackView.axis = .vertical
		addSubview(labelsStackView)
		labelsStackView.constraintToSuperview(edges: [.leading, .bottom])
		
		// title
		titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		titleLabel.textColor = .white
		
		// subtitle
		subTitleLabel.numberOfLines = 0
		subTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
		subTitleLabel.textColor = .white
	}
	
	private func addSubLabelsGradient() {
		subLabelsGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]

		subLabelsGradientLayer.startPoint = CGPoint(x: 0, y: 0.8)
		subLabelsGradientLayer.endPoint = CGPoint(x: 0, y: 1)

		layer.addSublayer(subLabelsGradientLayer)
	}
	
	private func updateUI(using model: ViewModel) {
		imageView.image = UIImage(named: model.imageName)
		titleLabel.text = model.titleText
		subTitleLabel.text = model.subTitleText
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()

		// set frame for gradient layer after current view did layout itself
		subLabelsGradientLayer.frame = frame
	}
}
