//
//  CameraView.swift
//  Align
//
//  Created by William Rule on 6/22/24.
//

import UIKit
import SwiftUI
import AVFoundation

//
//struct CameraView: View {
//    @State private var isShowingImagePicker = false
//    @State private var image: UIImage? = nil
//    @State private var isCameraAuthorized = false
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//            } else {
//                Text("Tap the button to capture an image")
//                    .padding()
//            }
//            
//            Button(action: {
//                checkCameraPermission()
//            }) {
//                Text("Capture Image")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $image)
//        }
//    }
//    
//    private func checkCameraPermission() {
//        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
//        
//        switch authorizationStatus {
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if granted {
//                    DispatchQueue.main.async {
//                        self.isShowingImagePicker = true
//                    }
//                }
//            }
//        case .restricted, .denied:
//            // Handle restricted or denied access
//            // You might want to show an alert to the user explaining why the app needs camera access
//            break
//        case .authorized:
//            self.isShowingImagePicker = true
//        @unknown default:
//            break
//        }
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
