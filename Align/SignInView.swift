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

    var body: some View {
        VStack {
            if signInWithApple.isSignedIn {
                Text("You're signed in!")
                CameraView()
            } else {
                SignInWithAppleButton()
                    .frame(width: 280, height: 45)
                    .onTapGesture {
                        signInWithApple.startSignInWithAppleFlow()
                    }
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                signInWithApple.isSignedIn = true
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
