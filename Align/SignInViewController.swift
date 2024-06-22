//
//  SignInViewController.swift
//  Align
//
//  Created by William Rule on 6/22/24.
//
import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {
    
    private let signInWithApple = SignInWithApple()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signInButton = ASAuthorizationAppleIDButton()
        signInButton.addTarget(self, action: #selector(handleSignInWithApple), for: .touchUpInside)
        signInButton.center = view.center
        view.addSubview(signInButton)
    }
    
    @objc func handleSignInWithApple() {
        signInWithApple.startSignInWithAppleFlow()
    }
}

