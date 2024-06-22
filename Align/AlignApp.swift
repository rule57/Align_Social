//
//  AlignApp.swift
//  Align
//
//  Created by William Rule on 6/16/24.
//
// Gemini API Code - AIzaSyBmW81r2vCCEttGLaYIedfYb4Oph93Zu-A
//import SwiftUI
//import FirebaseCore
//import Supabase
//import Firebase
//import FirebaseAuth
//
//
//@main
//class AppDelegate: NSObject, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//            FirebaseApp.configure()
//            return true
//        }
//  }
//
//
import SwiftUI
import Firebase

@main
struct AlignApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

