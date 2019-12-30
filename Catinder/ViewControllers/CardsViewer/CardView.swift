//
//  CardView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CardViewModelRepresentable {
	var viewModel: CardView.ViewModel { get }
}

class CardView: UIView {
	struct ViewModel {
		let imageName: String
		let headerText: String
		let titleText: String
		let subtitleText: String
	}
	
	private let imageView = UIImageView()
	private let subLabelsGradientLayer = CAGradientLayer()
	private let headerLabel = UILabel()
	private let titleLabel = UILabel()
	private let subtitleLabel = UILabel()

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
		let labelsStackView = UIStackView(arrangedSubviews: [headerLabel, titleLabel, subtitleLabel])
		labelsStackView.setCustomSpacing(16, after: titleLabel)
		labelsStackView.axis = .vertical

		addSubview(labelsStackView)
		labelsStackView.constraintToSuperview(edges: [.leading, .trailing, .bottom], insets: UIEdgeInsets(top: 0, left: 14, bottom: 28, right: 0))
		
		// header
		headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		headerLabel.textColor = .white
		
		// title
		titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
		titleLabel.textColor = UIColor(white: 0.98, alpha: 1)
		
		// subtitle
		subtitleLabel.numberOfLines = 0
		subtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		subtitleLabel.textColor = UIColor(white: 0.96, alpha: 1)
	}
	
	private func addSubLabelsGradient() {
		subLabelsGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]

		subLabelsGradientLayer.startPoint = CGPoint(x: 0, y: 0.6)
		subLabelsGradientLayer.endPoint = CGPoint(x: 0, y: 1)

		layer.addSublayer(subLabelsGradientLayer)
	}
	
	private func updateUI(using model: ViewModel) {
		imageView.image = UIImage(named: model.imageName)
		headerLabel.text = model.headerText
		titleLabel.text = model.titleText
		subtitleLabel.text = model.subtitleText
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()

		// set frame for gradient layer after current view did layout itself
		subLabelsGradientLayer.frame = frame
	}
}
