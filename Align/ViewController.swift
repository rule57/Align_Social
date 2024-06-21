//
//  ViewController.swift
//  Align
//
//  Created by William Rule on 6/17/24.
//

import SwiftUI
import Supabase
import AuthenticationServices

class ViewController: UIViewController {
    var supabaseClient: SupabaseClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInWithApple()
        
        // Initialize Supabase client
        let supabaseUrl = URL(string: "https://efdkjonuigverdgalmhl.supabase.co")!
        let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmZGtqb251aWd2ZXJkZ2FsbWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2ODIyMjAsImV4cCI6MjAzNDI1ODIyMH0.8jfhTehddnmyUHEkrXGsA4jny7nxPn-PVAAFC0cTKPQ"
        supabaseClient = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }
    
    //GPT's Answer (possibly outdated)
    
//    func setupSignInWithApple() {
//        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
//    }
//    
//    @objc func handleAuthorizationAppleIDButtonPress() {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//        
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//    
//    func authorizationController(_ controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName//Xcode Sug
//            let email = appleIDCredential.email //Xcode Sug
//            let identitiyToken = appleIDCredential.identityToken
//            let authorizationCode = appleIDCredential.authorizationCode
//            
//            print("User Identifier: \(userIdentifier)") //Xcode Sug
//            
//            let identityTokenString = String(data: identityToken!, encoding: .utf8)
//            let authorizationCodeString = String(data: authorizationCode!, encoding: .utf8)
//            
//            print("Identity Token: \(identityTokenString ?? "No Identity Token")")
//            print("Authorization Code: \(authorizationCodeString ?? "No Authorization Code")")
//            
//            authenticateWithSupabase(identityToken: identityTokenString, authorizationCode: authorizationCodeString)
//            
//            
//        }
//    }
//    
//    func auntorizationController(controller: ASAuthorizationController, did CompleteWithError error: Error){
//        //GPT SAYS HANDLE ERROR?
//        
//    }
//    
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//    
//    func authenticateWithSupabase(identitiyToken: String?, authorizationCode: String?) {
//        //GPT SAYS IMPLIMENT SUPABASE AUTHENITIATION HERE
//    }
    
}


