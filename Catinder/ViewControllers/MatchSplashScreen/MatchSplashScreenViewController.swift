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

	// Blur view
	private let blurView = UIVisualEffectView(effect: nil)

	// Labels
	private let matchTitleLabel = UILabel(text: "Совпадение!", color: .white, alignment: .center, font: .systemFont(ofSize: 36, weight: .medium))
	private let matchDescriptionLabel = UILabel(text: "Вы, и %secondUser% понравились друг другу.", color: .white, allowMultipleLines: true, font: .systemFont(ofSize: 18))

	// Profile images
	private let userProfileImageView = UIImageView(image: UIImage(named: "Cat_Marusia"))
	private let matchedProfileImageView = UIImageView(image: UIImage(named: "Cat_Bob_1"))
	
	// Buttons
	private let sendMessageButton = CatinderTextButton(text: "Отправить сообщение")
	private let continueSwipingButton = CatinderTextButton(text: "Продолжить поиски")
	
	// Constants
	private let profileImageRotationAngle = Angle(degrees: 40).radians

	// del - test button
	private let playAnimationButton = UIButton(type: .custom)
	
	
	// MARK: - Setup
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
		
		// test button
		playAnimationButton.setTitle("Play animation", for: .normal)
		view.addSubview(playAnimationButton)
		playAnimationButton.constrainToSuperview(anchors: [.bottom, .centerX], paddings: .bottom(20))
		playAnimationButton.addTarget(nil, action: #selector(playAnimation), for: .touchUpInside)
	}
	
	private func setupSubviews() {
		view.backgroundColor = .lightGray
		
		// blur view
		view.insertSubview(blurView, at: 0)
		blurView.constrainToSuperview(respectSafeArea: false)
		
		// profiles images
		setupProfileImageView(userProfileImageView)
		setupProfileImageView(matchedProfileImageView)
		
		// profiles stack
		let profilesStack = UIStackView(arrangedSubviews: [userProfileImageView, matchedProfileImageView])
		profilesStack.axis = .horizontal
		profilesStack.spacing = 30
		
		// buttons
		sendMessageButton.constrainHeight(to: 50)
		sendMessageButton.addTarget(self, action: #selector(sendMessageButtonDidTapped), for: .touchUpInside)

		continueSwipingButton.constrainHeight(to: 50)
		continueSwipingButton.addTarget(self, action: #selector(continueSwipingButtonDidTapped), for: .touchUpInside)
		
		// main stack
		let mainStack = UIStackView(arrangedSubviews: [matchTitleLabel, matchDescriptionLabel, profilesStack, sendMessageButton, continueSwipingButton])
		mainStack.axis = .vertical
		mainStack.spacing = 10
		mainStack.setCustomSpacing(40, after: matchDescriptionLabel)
		mainStack.setCustomSpacing(40, after: profilesStack)
		
		view.addSubview(mainStack)
		mainStack.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	private func setupProfileImageView(_ profileImageView: UIImageView) {
		let profileImageSideSize = view.frame.width * 0.33

		profileImageView.contentMode = .scaleAspectFill
		profileImageView.constrainSize(to: .square(profileImageSideSize))
		profileImageView.layer.round(radius: profileImageSideSize / 2)
		profileImageView.layer.setBorder(size: 2, color: .white)
	}
	
	
	// MARK: - Action methods
	
	@objc private func sendMessageButtonDidTapped() {
		print("Send message.")
	}
	
	@objc private func continueSwipingButtonDidTapped() {
		print("Continue swiping.")
	}
	
	
	// MARK: - Animation
	
	// Set all animated values into initial states.
	private func prepareForAnimation() {
		blurView.effect = UIBlurEffect(style: .light)
		
		matchTitleLabel.alpha = 0
		matchDescriptionLabel.alpha = 0
		
		let offscreenX = UIScreen.main.bounds.width
		userProfileImageView.transform = CGAffineTransform(translationX: offscreenX, y: 0).rotated(by: -profileImageRotationAngle)
		matchedProfileImageView.transform = CGAffineTransform(translationX: -offscreenX, y: 0).rotated(by: profileImageRotationAngle)
		
		sendMessageButton.transform = CGAffineTransform(translationX: -offscreenX, y: 0)
		continueSwipingButton.transform = CGAffineTransform(translationX: offscreenX, y: 0)
	}
	
	@objc private func playAnimation() {
		prepareForAnimation()

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
