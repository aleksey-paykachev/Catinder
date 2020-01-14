//
//  CardView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CardViewDelegate: class {
	func cardDidSwiped(_ cardView: CardView, direction: CardView.SwipeDirection)
	func showMoreInfoButtonDidPressed(for cardId: String)
}

class CardView: UIView {
	private enum State {
		case present
		case removing(direction: SwipeDirection)
		case removed
	}
	
	enum SwipeDirection {
		case left
		case right
	}
	
	// Constants
	let cardRemovalHorizontalThreshold: CGFloat = 100
	let panRotationSpeedDegreesPerPixel: CGFloat = 0.12

	// Properties
	private let imageView = UIImageView()
	private let activeImagePageControl = CustomPageControl()
	private let subLabelsGradientLayer = CAGradientLayer()
	private let headerLabel = UILabel()
	private let titleLabel = UILabel()
	private let subtitleLabel = UILabel()
	private let moreInfoButton = UIButton(type: .detailDisclosure)
	
	weak var delegate: CardViewDelegate?
	private var viewModel: CardViewModel { didSet { updateUI() } }
	private var state = State.present

	
	// MARK: - Init
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(viewModel: CardViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)

		setupView()
		setupGestures()
		updateUI()
	}
	
	
	// MARK: - Public methods
	
	func remove(direction: SwipeDirection) {
		state = .removing(direction: direction)
		removeCardWithAnimation(direction: direction)
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		setupLayer()
		setupImageView()
		setupLabels()
		setupActiveImagePageControl()
		setupMoreInfoButton()
	}
	
	private func setupLayer() {
		layer.cornerRadius = 14
		layer.masksToBounds = true
		
		layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
		layer.borderWidth = 1
	}
	
	private func setupImageView() {
		addSubview(imageView)
		imageView.constrainToSuperview()
		
		imageView.contentMode = .scaleAspectFill
	}
	
	private func setupLabels() {
		addSubLabelsGradient() // add gradient behind labels to improve readability
		
		// put all labels inside one stack
		let labelsStackView = UIStackView(arrangedSubviews: [headerLabel, titleLabel, subtitleLabel])
		labelsStackView.setCustomSpacing(16, after: titleLabel)
		labelsStackView.axis = .vertical
		
		addSubview(labelsStackView)
		labelsStackView.constrainToSuperview(anchors: [.leading, .trailing, .bottom], paddings: .horizontal(14) + .bottom(28))
		
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
	
	private func setupActiveImagePageControl() {
		addSubview(activeImagePageControl)
		activeImagePageControl.constrainToSuperview(anchors: [.top, .leading, .trailing], paddings: .top(10) + .horizontal(16))

		activeImagePageControl.numberOfPages = viewModel.imagesCount
	}
	
	private func setupMoreInfoButton() {
		moreInfoButton.tintColor = .white
		moreInfoButton.addTarget(self, action: #selector(showMoreInfo), for: .touchUpInside)
		
		addSubview(moreInfoButton)
		moreInfoButton.constrainToSuperview(anchors: .trailing, paddings: .trailing(14))
		moreInfoButton.constrainTo(headerLabel, anchors: .centerY)
	}
	
	
	// MARK: - Gestures
	
	private func setupGestures() {
		// tap - change photos
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
		addGestureRecognizer(tapGestureRecognizer)

		// pan - swipe card
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
		addGestureRecognizer(panGestureRecognizer)
	}
	
	@objc private func handleTapGesture(gesture: UITapGestureRecognizer) {
		let tapLocation = gesture.location(in: self)
		let isRightSideDidTapped = tapLocation.x > frame.width / 2
		
		if isRightSideDidTapped {
			viewModel.advanceToNextImage()
		} else {
			viewModel.goToPreviousImage()
		}
	}
	
	@objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .began, .changed:
			let displacement = gesture.translation(in: nil)
			applyCardAffineTransform(with: displacement)
			state = calculateState(basedOn: displacement.x)
			
		case .ended, .cancelled, .failed:
			if case let State.removing(direction) = state {
				removeCardWithAnimation(direction: direction)
			} else {
				putCardBackWithAnimation()
			}

		default:
			break
		}
	}
	
	private func applyCardAffineTransform(with displacement: CGPoint) {
		// rotation
		let angle = Angle(degrees: displacement.x * panRotationSpeedDegreesPerPixel)
		let rotationTransform = CGAffineTransform(rotationAngle: angle.radians)
		
		// displacement
		let displacementTransform = CGAffineTransform(translationX: displacement.x, y: displacement.y)
		
		transform = rotationTransform.concatenating(displacementTransform)
	}
	
	private func calculateState(basedOn horizontalDisplacement: CGFloat) -> State {
		if horizontalDisplacement > cardRemovalHorizontalThreshold {
			return .removing(direction: .right)
		} else if horizontalDisplacement < -cardRemovalHorizontalThreshold {
			return .removing(direction: .left)
		}
		
		return .present
	}
	
	
	// MARK: - Card methods
	
	private func removeCardWithAnimation(direction: SwipeDirection) {
		UIView.animate(withDuration: 0.5, animations: {
			#warning("Fix buggy card removal animation")
			let multiplyer: CGFloat = direction == .right ? 1 : -1
			let dx = 1000 * multiplyer
			let angle = Angle(degrees: 40).radians * multiplyer
			self.transform = self.transform.translatedBy(x: dx, y: 0).rotated(by: angle)
		}) { _ in
			if case State.removing(_) = self.state {
				self.delegate?.cardDidSwiped(self, direction: direction)
				self.state = .removed
			}
		}
	}
	
	private func putCardBackWithAnimation() {
		UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
			
			self?.transform = .identity
		})
	}
	
	@objc private func showMoreInfo() {
		delegate?.showMoreInfoButtonDidPressed(for: viewModel.cardId)
	}
	
	private func updateUI() {
		imageView.image = viewModel.activeImage
		activeImagePageControl.currentPage = viewModel.activeImageIndex
		headerLabel.text = viewModel.headerText
		titleLabel.text = viewModel.titleText
		subtitleLabel.text = viewModel.subtitleText
	}
	
	
	// MARK: - View methods
	
	override func layoutSubviews() {
		super.layoutSubviews()

		// set frame for gradient layer each time current view layouts itself
		subLabelsGradientLayer.frame = frame
	}
}
