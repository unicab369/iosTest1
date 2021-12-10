//
//  AnimationController.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

import UIKit

class AnimationController: UIViewController {
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "AnimationView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var fadeInButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.onReturn?()
    }
    
    @IBAction func fadeInButtonTapped(_ sender: Any) {
        rotateAnimation(inOrOut: fadeInOrOut)
        fadeInOrOut = !fadeInOrOut
    }
    
    // MARK: - Properties
    var onReturn: (()->Void)?
    private var isDragging = false
    
    private var fadeInOrOut = false  {
        didSet {
            let title = fadeInOrOut ? "FADE IN" : "FADE OUT"
            fadeInButton.setAttributedTitle(title.attributedString(withColor: StyleColor.white), for: .normal)
        }
    }   // true for fadeIn false for fadeOut
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .white
        topView.backgroundColor = StyleColor.blue
        topLabel.attributedText = "Animation".attributedString(withColor: StyleColor.white)
        topLabel.font = StyleFont.headerFont
        
        fadeInButton.backgroundColor = StyleColor.blue
        fadeInButton.titleLabel?.font = StyleFont.buttonFont
        fadeInButton.setAttributedTitle("FADE OUT".attributedString(withColor: StyleColor.white), for: .normal)
        
        view.backgroundColor = StyleColor.viewBackground
    }
    
    private func rotateAnimation(inOrOut: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut , .allowUserInteraction]) { [weak self] in
            self?.imageView.alpha = inOrOut ? 1 : 0
            if (inOrOut == false) {
                self?.imageView.transform = CGAffineTransform(scaleX: 50, y: 50)
            }
        } completion: { finished in
            //
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut , .allowUserInteraction]) { [weak self] in
            if (inOrOut == false) {
                self?.imageView.transform = CGAffineTransform(rotationAngle: .pi)
            }
        } completion: { [weak self] finished in
            self?.imageView.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
}

// source: https://www.youtube.com/watch?v=3A1sPCJaqGI
// MARK: - handle image drag and drop

extension AnimationController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.imageView)
        
        if imageView.bounds.contains(location) {
            self.isDragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else { return }
        let location = touch.location(in: self.view)
        imageView.frame.origin.x = location.x - imageView.frame.size.width/2
        imageView.frame.origin.y = location.y - imageView.frame.size.height/2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isDragging = true
    }
}

