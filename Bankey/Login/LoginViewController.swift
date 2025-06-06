//
//  ViewController.swift
//  Bankey
//
//  Created by Paweł Łąk on 28/05/2025.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    let viewTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 75)
        label.text = "Bankey"
        label.alpha = 0
        return label
    }()
    
    let signInButton = UIButton(type: .system)
    
    weak var delegate : LoginViewControllerDelegate?
    
    // animation
    var leadingEdgeOnScreen: CGFloat = 200
    var leadingEdgeOffScreen: CGFloat = -5000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    
    var userName: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.textAlignment = NSTextAlignment.center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        label.text = "Error failure"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    
    private func style() {
        view.backgroundColor = .systemOrange
        
        loginView.translatesAutoresizingMaskIntoConstraints=false
        signInButton.translatesAutoresizingMaskIntoConstraints=false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action:#selector(signInTapped), for: .primaryActionTriggered)
        
        
        
    }
    
    private func layout() {
        view.addSubview(viewTitle)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            viewTitle.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            viewTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor,  multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        titleLeadingAnchor =  viewTitle.bottomAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier:leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
     
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        login()
    }
    
    private func login() {
        guard let userName = userName,
              let password = password
                
        else {
            assertionFailure("username should never be nill")
            return
        }
        
        if userName.isEmpty || password.isEmpty {
            configureViews(withMessage: "Username or password cannot be blank")
            return
        }
        
        if userName=="AB" && password == "AB"
        {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else
        {
            configureViews(withMessage: "incorrect username or password")
        }
    }
    
    private func configureViews(withMessage message:String) {
        errorMessageLabel.isHidden=false
        errorMessageLabel.text=message
        shakeButtom()
    }
    
    private func shakeButtom() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        animation.duration = 0.6
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}


extension LoginViewController
{
    private func animate()
    {
        let animator1 = UIViewPropertyAnimator(duration: 3, curve: .easeInOut)
        {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: 3, curve: .easeInOut)
        {
            self.viewTitle.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        animator2.startAnimation()
    }
}
