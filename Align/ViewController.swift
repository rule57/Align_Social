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
        //setupSignInWithApple()
        
        // Initialize Supabase client
        let supabaseUrl = URL(string: "https://efdkjonuigverdgalmhl.supabase.co")!
        let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmZGtqb251aWd2ZXJkZ2FsbWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2ODIyMjAsImV4cCI6MjAzNDI1ODIyMH0.8jfhTehddnmyUHEkrXGsA4jny7nxPn-PVAAFC0cTKPQ"
        supabaseClient = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }

}



class SignInViewModel: ObservableObject {
    
    func signInWithApple() {
        
    }
}



struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false

    var body: some View {
        if isSignedIn {
            Text("Welcome back!")
        } else {
            VStack(spacing: 20) {
                Text("Sign In")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                Button(action: {
                    signIn(email: email, password: password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                SignInWithAppleButtonView()
                    .frame(width: 280, height: 45)
                    .onTapGesture {
                        performSignInWithApple()
                    }
            }
            .padding()
            .onAppear {
                checkSignIn()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        // Save credentials securely
        if let emailData = email.data(using: .utf8), let passwordData = password.data(using: .utf8) {
            KeychainHelper.save(key: "userEmail", data: emailData)
            KeychainHelper.save(key: "userPassword", data: passwordData)
        }
        
        // Set signed in state
        isSignedIn = true
        print("Signed in with Email: \(email), Password: \(password)")
    }
    
    func checkSignIn() {
        // Load credentials from Keychain
        if let emailData = KeychainHelper.load(key: "userEmail"), let passwordData = KeychainHelper.load(key: "userPassword") {
            email = String(data: emailData, encoding: .utf8) ?? ""
            password = String(data: passwordData, encoding: .utf8) ?? ""
            isSignedIn = !email.isEmpty && !password.isEmpty
        }
    }
    
    private func performSignInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = makeCoordinator()
        authorizationController.presentationContextProvider = makeCoordinator()
        authorizationController.performRequests()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        
        var parent: SignInView
        
        init(parent: SignInView) {
            self.parent = parent
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return UIApplication.shared.windows.first!
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userIdentifier = appleIDCredential.user
                let email = appleIDCredential.email ?? "Email not available"
                let fullName = appleIDCredential.fullName?.givenName ?? "Name not available"
                
                // Save the userIdentifier to Keychain for future use
                KeychainHelper.save(key: "appleUserIdentifier", data: userIdentifier.data(using: .utf8)!)
                
                // Update the sign-in state
                parent.isSignedIn = true
                print("Signed in with Apple ID: \(userIdentifier), Email: \(email), Name: \(fullName)")
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Failed to sign in with Apple: \(error.localizedDescription)")
        }
    }
}

struct SignInWithAppleButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
