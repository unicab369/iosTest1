//
//  ChatController.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "LoginView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var emailTextField: CustomTextField1!
    @IBOutlet weak var passwordTextField: CustomTextField1!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.onReturn?()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.handleLogin()
    }
    
    // MARK: - Properties
    var onReturn: (()->Void)?
    private var alert: UIAlertController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .white
        topView.backgroundColor = StyleColor.blue
        loginButton.tintColor = .white
        topLabel.font = StyleFont.headerFont
        topLabel.attributedText = "Login".attributedString(withColor: StyleColor.white)
        
        loginButton.backgroundColor = StyleColor.blue
        loginButton.titleLabel?.font = StyleFont.buttonFont
        loginButton.setAttributedTitle("LOGIN".attributedString(withColor: StyleColor.white), for: .normal)
    }
    
    private func handleLogin() {
        guard let email = emailTextField.text, let pass = passwordTextField.text else { return }
        let startTime = CFAbsoluteTimeGetCurrent()
        
        LoginClient.login(email: email, password: pass) { message in
            let runTime = CFAbsoluteTimeGetCurrent() - startTime
            
            DispatchQueue.main.async { [weak self] in
                guard let sself = self else { return }
                let output = "\(message). \nRunTime = \(Double(round(1000 * runTime) / 1000)) sec"
                sself.alert = UIAlertController(title: "Alert", message: output, preferredStyle: UIAlertController.Style.alert)
                sself.alert?.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] _ in
                    self?.onReturn?()
                }))
                sself.present(sself.alert!, animated: true, completion: nil)
            }
            
        } error: { [weak self] err in
            DispatchQueue.main.async { [weak self] in
                guard let sself = self else { return }
                sself.alert = UIAlertController(title: "Error", message: err, preferredStyle: UIAlertController.Style.alert)
                sself.alert?.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                sself.present(sself.alert!, animated: true, completion: nil)
            }
        }
    }
}
