//
//  AppDelegate.swift
//  Bankey
//
//  Created by Paweł Łąk on 28/05/2025.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    let accountSummary = AccountSummaryViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        registerForNotifications()
        
        let viCon = mainViewController
        viCon.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = loginViewController
        
        return true
    }
    
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
}

extension AppDelegate : LoginViewControllerDelegate
{
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        }else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate : OnboardingContainerViewControllerDelegate
{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutDelegate {
   @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}
 
extension AppDelegate
{
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with:window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
