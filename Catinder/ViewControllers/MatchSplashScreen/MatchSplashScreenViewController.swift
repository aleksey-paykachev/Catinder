//
//  MatchSplashScreenViewController.swift
//  Catinder
//
//  Created by Aleksey on 17/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class MatchSplashScreenViewController: UIViewController {
	// MARK: - Properties
	private let viewModel: MatchViewModel

	// Blur view
	private let blurView = UIVisualEffectView(effect: nil)

	// Labels
	private let matchTitleLabel = UILabel(text: "Совпадение!", color: .white, alignment: .center, font: .systemFont(ofSize: 36, weight: .medium))
	private let matchDescriptionLabel = UILabel(color: .white, alignment: .center, allowMultipleLines: true, font: .systemFont(ofSize: 18))

	// Profile images
	private let userProfileImageView = UIImageView()
	private let matchedProfileImageView = UIImageView()
	
	// Buttons
	private let sendMessageButton = CatinderPrimaryTextButton(text: "Отправить сообщение")
	private let continueSwipingButton = CatinderSecondaryTextButton(text: "Продолжить поиски")
	
	// Constants
	private let profileImageRotationAngle = Angle(40).radians

	
	// MARK: - Init
	
	init(viewModel: MatchViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		updateUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - ViewController lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		setupSubviews()
		prepareForAnimation()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		playAnimation()
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		view.layer.zPosition = 2 // place this view on top of all others
	}
	
	private func setupSubviews() {
		// blur view
		view.insertSubview(blurView, at: 0)
		blurView.constrainToSuperview(respectSafeArea: false)
		
		// profiles images
		setupProfileImageView(userProfileImageView)
		setupProfileImageView(matchedProfileImageView)
		
		// profiles stack
		let profilesStack = HStackView([userProfileImageView, matchedProfileImageView], spacing: 30)		
		
		// buttons
		sendMessageButton.constrainHeight(to: 50)
		sendMessageButton.addTarget(self, action: #selector(sendMessageButtonDidTapped), for: .touchUpInside)

		continueSwipingButton.constrainHeight(to: 50)
		continueSwipingButton.addTarget(self, action: #selector(continueSwipingButtonDidTapped), for: .touchUpInside)
		
		// main stack
		let mainStackSubviews = [matchTitleLabel, matchDescriptionLabel, profilesStack, sendMessageButton, continueSwipingButton]
		let mainStack = VStackView(mainStackSubviews, spacing: 10)
		mainStack.setCustomSpacing(40, after: matchDescriptionLabel)
		mainStack.setCustomSpacing(40, after: profilesStack)
		
		view.addSubview(mainStack)
		mainStack.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	private func setupProfileImageView(_ profileImageView: UIImageView) {
		let profileImageSideSize = view.frame.width * 0.33

		profileImageView.contentMode = .scaleAspectFill
		profileImageView.constrainSize(to: .square(profileImageSideSize))
		profileImageView.layer.roundCorners(radius: profileImageSideSize / 2)
		profileImageView.layer.setBorder(size: 2, color: .white)
	}
	
	
	// MARK: - Methods
	
	private func updateUI() {
		userProfileImageView.image = UIImage(named: viewModel.userProfileImageName)
		matchedProfileImageView.image = UIImage(named: viewModel.matchedProfileImageName)
		matchDescriptionLabel.text = "Вы, и \(viewModel.matchedProfileName) понравились друг другу."
	}

	@objc private func sendMessageButtonDidTapped() {
		let conversationViewModel = ConversationViewModel(collocutorName: viewModel.matchedProfileName, collocutorImageName: viewModel.matchedProfileImageName)
		let conversationViewController = ConversationViewController(viewModel: conversationViewModel)
		navigationController?.pushViewController(conversationViewController, animated: true)

		removeFromParentWithAnimation()
	}
	
	@objc private func continueSwipingButtonDidTapped() {
		removeFromParentWithAnimation()
	}
	
	private func removeFromParentWithAnimation() {
		UIView.animate(withDuration: 0.5, animations: {
			self.view.alpha = 0
		}) { _ in
			self.view.removeFromSuperview()
			self.removeFromParent()
		}
	}
	
	
	// MARK: - Appearance animation
	
	// Set all animated values into initial states.
	private func prepareForAnimation() {
		// labels
		matchTitleLabel.alpha = 0
		matchDescriptionLabel.alpha = 0
		
		// profiles images
		let offscreenX = UIScreen.main.bounds.width
		userProfileImageView.transform = CGAffineTransform(translationX: offscreenX, y: 0).rotated(by: -profileImageRotationAngle)
		matchedProfileImageView.transform = CGAffineTransform(translationX: -offscreenX, y: 0).rotated(by: profileImageRotationAngle)
		
		// buttons
		sendMessageButton.transform = CGAffineTransform(translationX: -offscreenX, y: 0)
		continueSwipingButton.transform = CGAffineTransform(translationX: offscreenX, y: 0)
	}
	
	@objc private func playAnimation() {
		// multiple steps animation
		
		UIView.animateKeyframes(withDuration: 2, delay: 0, options: [], animations: {
			// step 1 - add blur, show labels
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
				self.blurView.effect = UIBlurEffect(style: .dark)
				
				self.matchTitleLabel.alpha = 1
				self.matchDescriptionLabel.alpha = 1
			}
			
			// step 2 - show profiles
			UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
				self.userProfileImageView.transform = CGAffineTransform(rotationAngle: -self.profileImageRotationAngle)
				self.matchedProfileImageView.transform = CGAffineTransform(rotationAngle: self.profileImageRotationAngle)
			}
			
			// step 3 - rotate profiles and show buttons
			UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
				self.userProfileImageView.transform = .identity
				self.matchedProfileImageView.transform = .identity

				self.sendMessageButton.transform = .identity
				self.continueSwipingButton.transform = .identity
			}
		})
	}
}
