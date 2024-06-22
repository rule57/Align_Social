//
//  AlignApp.swift
//  Align
//
//  Created by William Rule on 6/16/24.
//
// Gemini API Code - AIzaSyBmW81r2vCCEttGLaYIedfYb4Oph93Zu-A

import SwiftUI
import FirebaseCore
import Supabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
struct AlignApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
