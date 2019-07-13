//
//  AppDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setupFirebase()
        setupSocialLogins()
        setupStatusBar()
        setupApp()
        setupTabBar()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if FacebookAuthManager.shared.handle(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        
        if GoogleAuthManager.shared.handle(open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        
        return false
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        if TwitterAuthManager.shared.handle(application, open: url, options: options) {
            return true
        }
        
        if GoogleAuthManager.shared.handle(open: url, options: options) {
            return true
        }
        
        if FacebookAuthManager.shared.handle(application, open: url, options: options) {
            return true
        }
        
        return false
    }
    
}

// MARK: Setup Methods

private extension AppDelegate {
    func setupStatusBar() {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
    }
    
    func setupApp() {
        let authManager = AuthManager.shared
        
        self.window?.rootViewController = authManager.getRootControllerByUserStatus()
        self.window?.makeKeyAndVisible()
    }
    
    func setupTabBar() {
        UITabBar.appearance().tintColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func setupSocialLogins() {
        GoogleAuthManager.shared.setup(delegate: self)
        TwitterAuthManager.shared.setup()
    }
    
}

// MARK: GIDSignInDelegate

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        GoogleAuthManager.shared.sign(signIn, didSignInFor: user, withError: error)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        GoogleAuthManager.shared.sign(signIn, didDisconnectWith: user, withError: error)
    }
}
