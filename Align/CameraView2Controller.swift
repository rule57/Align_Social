//
//  CameraView2Controller.swift
//  Align
//
//  Created by William Rule on 6/22/24.
//
import SwiftUI
import AVFoundation

//struct CameraView2Controller: View {
//    @State private var captureSession: AVCaptureSession!
//    @State private var previewLayer: AVCaptureVideoPreviewLayer!
//    @State private var capturePhotoOutput: AVCapturePhotoOutput!
//    @State private var capturedImage: UIImage?
//    @State private var showCapturedImage = false
//
//    var body: some View {
//        ZStack {
//            CameraPreview(captureSession: $captureSession, previewLayer: $previewLayer)
//                .edgesIgnoringSafeArea(.all)
//                .onAppear {
//                    setupCaptureSession()
//                }
//            
//            VStack {
//                Spacer()
//                
//                Button(action: {
//                    capturePhoto()
//                }) {
//                    Text("Capture")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 30)
//            }
//            
//            if showCapturedImage, let capturedImage = capturedImage {
//                CapturedImageView(image: capturedImage, show: $showCapturedImage)
//                    .edgesIgnoringSafeArea(.all)
//            }
//        }
//        .navigationBarHidden(true)
//    }
//
//    private func setupCaptureSession() {
//        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .photo
//        
//        guard let backCamera = AVCaptureDevice.default(for: .video) else {
//            print("Unable to access back camera!")
//            return
//        }
//        
//        do {
//            let input = try AVCaptureDeviceInput(device: backCamera)
//            captureSession.addInput(input)
//        } catch let error {
//            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
//            return
//        }
//        
//        capturePhotoOutput = AVCapturePhotoOutput()
//        capturePhotoOutput.isHighResolutionCaptureEnabled = true
//        captureSession.addOutput(capturePhotoOutput)
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.frame = UIScreen.main.bounds
//    }
//
//    private func capturePhoto() {
//        let settings = AVCapturePhotoSettings()
//        let coordinator = Coordinator(parent: self)
//        capturePhotoOutput.capturePhoto(with: settings, delegate: coordinator)
//    }
//}
//
//extension CameraView2Controller {
//    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
//        var parent: CameraView
//
//        init(parent: CameraView) {
//            self.parent = parent
//        }
//
//        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//            guard let imageData = photo.fileDataRepresentation() else { return }
//            parent.capturedImage = UIImage(data: imageData)
//            parent.showCapturedImage = true
//        }
//    }
//}
//
//struct CameraPreview: UIViewRepresentable {
//    @Binding var captureSession: AVCaptureSession!
//    @Binding var previewLayer: AVCaptureVideoPreviewLayer!
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//        view.layer.addSublayer(previewLayer)
//        captureSession.startRunning()
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//}
//
//struct CapturedImageView: View {
//    var image: UIImage
//    @Binding var show: Bool
//
//    var body: some View {
//        VStack {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            HStack {
//                Button(action: {
//                    saveImage()
//                }) {
//                    Text("Save")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                }
//                
//                Button(action: {
//                    show = false
//                }) {
//                    Text("Dismiss")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//            }
//            .padding()
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//    }
//
//    private func saveImage() {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        show = false
//    }
//}
//
