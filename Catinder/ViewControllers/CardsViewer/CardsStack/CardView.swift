//
//  CardView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CardViewDelegate: class {
	func cardDidSwiped(_ cardView: CardView, decision: RelationshipDecision)
	func showMoreInfoButtonDidPressed(for cardId: String)
}

class CardView: UIView {
	private enum State: Equatable {
		case present
		case removing(decision: RelationshipDecision)
		case removed
	}
	
	// Constants
	let cardRemovalHorizontalThreshold: CGFloat = 100
	let panRotationSpeedDegreesPerPixel: CGFloat = 0.12

	// Subviews
	private let imageView = CatinderImageView()
	private let activeImagePageControl = CatinderPageControl()

	// Labels
	private let titleLabel = UILabel(color: .profileCardTitle, font: .systemFont(ofSize: 36, weight: .medium))
	private let contentLabel = UILabel(color: .profileCardContent, allowMultipleLines: true, font: .systemFont(ofSize: 18, weight: .medium))

	// Properties
	weak var delegate: CardViewDelegate?
	private(set) var viewModel: CardViewModel { didSet { updateUI() } }
	private var activeImageName: String?
	private var state = State.present
	private var panGestureRecognizer: UIPanGestureRecognizer!

	
	// MARK: - Init
	
	init(viewModel: CardViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)

		setupView()
		setupGestures()
		updateUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Public methods
	
	func remove(decision: RelationshipDecision) {
		guard state == .present else { return } // prevent multiple remove() calls
		
		state = .removing(decision: decision)
		removeCardWithAnimation(decision: decision)
	}
	
	func cancelAllUserInteractions() {
		panGestureRecognizer.state = .cancelled
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		backgroundColor = .background
		
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
	}
	
	private func setupLabels() {
		// add gradient behind labels to improve readability
		addSubLabelsGradient()

		let labelsStackView = VStackView([titleLabel, contentLabel], spacing: 12)

		addSubview(labelsStackView)
		labelsStackView.constrainToSuperview(anchors: [.leading, .trailing, .bottom], paddings: .horizontal(14) + .bottom(28))
	}
	
	private func addSubLabelsGradient() {
		let gradientSecondColor = UIColor.black.withAlphaComponent(0.6)
		let gradientView = GradientView([.clear, gradientSecondColor], at: [0.6, 1])
		addSubview(gradientView)
		gradientView.constrainToSuperview()
	}
	
	private func setupActiveImagePageControl() {
		addSubview(activeImagePageControl)
		activeImagePageControl.constrainToSuperview(anchors: [.top, .leading, .trailing], paddings: .top(10) + .horizontal(16))

		activeImagePageControl.numberOfPages = viewModel.imagesCount
	}
	
	private func setupMoreInfoButton() {
		let moreInfoButton = UIButton()
		moreInfoButton.setImage(UIImage(named: "MoreInfo"), for: .normal)
		moreInfoButton.addTarget(self, action: #selector(showMoreInfo), for: .touchUpInside)
		moreInfoButton.tintColor = .profileCardTint
		
		addSubview(moreInfoButton)
		moreInfoButton.constrainSize(to: .square(32))
		moreInfoButton.constrainToSuperview(anchors: .trailing, paddings: .trailing(14))
		moreInfoButton.constrainTo(titleLabel, anchors: .centerY)
	}
	
	
	// MARK: - Gestures
	
	private func setupGestures() {
		// tap - change photos
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		addGestureRecognizer(tapGestureRecognizer)

		// pan - swipe card
		panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
		addGestureRecognizer(panGestureRecognizer)
	}
	
	@objc private func handleTapGesture(gesture: UITapGestureRecognizer) {
		let tapLocation = gesture.location(in: self)
		let isRightSideDidTapped = tapLocation.x > frame.width / 2
		
		// try to change to different image if there is one
		let didChangedToDifferentImage = isRightSideDidTapped ? viewModel.advanceToNextImage() : viewModel.goToPreviousImage()

		// if there is no, rotate card around y-axis a little bit to indicate it
		if !didChangedToDifferentImage {
			layer.zPosition = 100 // bring to top to prevent overlapping with bottom cards

			var transform = CATransform3DIdentity
			transform.m34 = 1 / 800 * (isRightSideDidTapped ? -1 : 1) // 3d-perspective
			transform = CATransform3DRotate(transform, Angle(7).radians, 0, 1, 0) // rotation

			layer.animateTransform(to: transform, duration: 0.2, reverse: true, easing: .easeOut) {
				self.layer.transform = CATransform3DIdentity
				self.layer.zPosition = 0
			}
		}
	}
	
	@objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .began, .changed:
			let displacement = gesture.translation(in: nil)
			applyCardAffineTransform(with: displacement)
			state = calculateState(basedOn: displacement.x)
			
		case .cancelled, .failed:
			putCardBackWithAnimation()
			
		case .ended:
			if case let State.removing(decision) = state {
				removeCardWithAnimation(decision: decision)
			} else {
				putCardBackWithAnimation()
			}

		default:
			break
		}
	}
	
	private func applyCardAffineTransform(with displacement: CGPoint) {
		// rotation
		let angle = Angle(displacement.x * panRotationSpeedDegreesPerPixel)
		let rotationTransform = CGAffineTransform(rotationAngle: angle.radians)
		
		// displacement
		let displacementTransform = CGAffineTransform(translationX: displacement.x, y: displacement.y)
		
		transform = rotationTransform.concatenating(displacementTransform)
	}
	
	private func calculateState(basedOn horizontalDisplacement: CGFloat) -> State {
		if horizontalDisplacement > cardRemovalHorizontalThreshold {
			return .removing(decision: .like(type: .regular))
		} else if horizontalDisplacement < -cardRemovalHorizontalThreshold {
			return .removing(decision: .dislike)
		}
		
		return .present
	}
	
	
	// MARK: - Card methods
	
	private func removeCardWithAnimation(decision: RelationshipDecision) {
		// calculate final position transform
		let multiplier: CGFloat = decision == .dislike ? -1 : 1
		let offscreenX = 2 * UIScreen.main.bounds.width * multiplier
		let angle = Angle(40).radians * multiplier

		let finalTransformState = CGAffineTransform(translationX: offscreenX, y: transform.ty).rotated(by: angle)
		let final3dTransformState = CATransform3DMakeAffineTransform(finalTransformState)

		// animate
		layer.animateTransform(to: final3dTransformState, duration: 0.8, easing: .easeOut) {
			self.delegate?.cardDidSwiped(self, decision: decision)
			self.state = .removed
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
		if let imageName = viewModel.activeImageName, imageName != activeImageName {
			imageView.showActivityIndicator()
			
			DataManager.shared.getImage(name: imageName) { [weak self] result in
				if case Result.success(let image) = result {
					self?.activeImageName = imageName
					self?.imageView.set(image)					
				}
			}
		}

		activeImagePageControl.currentPage = viewModel.activeImageIndex
		titleLabel.text = viewModel.title
		contentLabel.text = viewModel.content
	}
}
