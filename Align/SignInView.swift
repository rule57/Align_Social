//
//  SignInView.swift
//  Align
//
//  Created by William Rule on 6/22/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import Firebase

struct SignInView: View {
    @StateObject private var signInWithApple = SignInWithApple()
    @State private var navigateToCameraView = false

    var body: some View {
        NavigationView {
            VStack {
                if signInWithApple.isSignedIn {
                    NavigationLink(destination: CameraView(), isActive: $navigateToCameraView) {
                        EmptyView()
                    }
                    .hidden()
                    
                    // Automatically navigate to CameraView when signed in
                    Button(action: {
                        navigateToCameraView = true
                    }) {
                        Text("Proceed to Camera")
                    }
                } else {
                    SignInWithAppleButton()
                        .frame(width: 280, height: 45)
                        .onTapGesture {
                            signInWithApple.startSignInWithAppleFlow { success in
                                if success {
                                    navigateToCameraView = true
                                }
                            }
                        }
                }
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    signInWithApple.isSignedIn = true
                    navigateToCameraView = true
                }
            }
        }
    }
}

struct SignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

//
//
//struct SignInView: View {
//    @StateObject private var signInWithApple = SignInWithApple()
//
//    var body: some View {
//        VStack {
//            if signInWithApple.isSignedIn {
//                Text("You're signed in!")
//                CameraView()
//                
//            } else {
//                SignInWithAppleButton()
//                    .frame(width: 280, height: 45)
//                    .onTapGesture {
//                        signInWithApple.startSignInWithAppleFlow()
//                    }
//            }
//        }
//        .onAppear {
//            if Auth.auth().currentUser != nil {
//                signInWithApple.isSignedIn = true
//            }
//        }
//    }
//}
//
//struct SignInWithAppleButton: UIViewRepresentable {
//    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
//        return ASAuthorizationAppleIDButton()
//    }
//
//    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
//}
//
//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
