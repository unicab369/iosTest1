//
//  MenuController.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class MenuController: UIViewController {
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "MenuView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topTittle: UILabel!
    @IBOutlet weak var chatButton: CustomButtom1!
    @IBOutlet weak var loginButton: CustomButtom1!
    @IBOutlet weak var animationButton: CustomButtom1!
    
    // MARK: - Actions
    @IBAction func chatButtonTapped(_ sender: Any) {
        let chatVC = ChatController()
        
        chatVC.onReturn = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let loginVC = LoginController()
        
        loginVC.onReturn = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func animationButtonTapped(_ sender: Any) {
        let animationVC = AnimationController()
        
        animationVC.onReturn = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(animationVC, animated: true)
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.backgroundColor = StyleColor.blue
        topTittle.font = StyleFont.headerFont
        topTittle.attributedText = "Coding Tasks".attributedString(withColor: StyleColor.white)
        
        setup()
    }
    
    private func setup() {
        chatButton.setImageWithName("ic_chat")
        loginButton.setImageWithName("ic_login")
        animationButton.setImageWithName("ic_animation")
        
        chatButton.titleLabel?.font = StyleFont.buttonFont
        loginButton.titleLabel?.font = StyleFont.buttonFont
        animationButton.titleLabel?.font = StyleFont.buttonFont
        
    }
}
