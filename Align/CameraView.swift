
import SwiftUI
import AVFoundation
struct CameraView: View {
    @State private var captureSession: AVCaptureSession?
    @State private var previewLayer: AVCaptureVideoPreviewLayer?
    @State private var capturePhotoOutput: AVCapturePhotoOutput?
    @State private var capturedImage: UIImage?
    @State private var showCapturedImage = false

    var body: some View {
        ZStack {
            if let previewLayer = previewLayer {
                CameraPreview(previewLayer: previewLayer)
                    .edgesIgnoringSafeArea(.all)
            }

            
            VStack {
                Spacer()
                
                Button(action: {
                    capturePhoto()
                    print("Capture Clicked")
                }) {
                    Text("Capture")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            
            if showCapturedImage, let capturedImage = capturedImage {
                CapturedImageView(image: capturedImage, show: $showCapturedImage)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            setupCaptureSession()
        }
        .onDisappear {
            captureSession?.stopRunning()
        }
    }

    private func setupCaptureSession() {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            let captureSession = AVCaptureSession()
            captureSession.sessionPreset = .photo
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            } else {
                print("Unable to add input to capture session")
                return
            }
            
            let capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput.isHighResolutionCaptureEnabled = true
            if captureSession.canAddOutput(capturePhotoOutput) {
                captureSession.addOutput(capturePhotoOutput)
            } else {
                print("Unable to add photo output to capture session")
                return
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = UIScreen.main.bounds
            
            self.captureSession = captureSession
            self.previewLayer = previewLayer
            self.capturePhotoOutput = capturePhotoOutput
            
            captureSession.startRunning()
        } catch let error {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }

    private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        capturePhotoOutput?.capturePhoto(with: settings, delegate: Coordinator(parent: self))
    }
}


extension CameraView {
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            guard let imageData = photo.fileDataRepresentation() else { return }
            parent.capturedImage = UIImage(data: imageData)
            parent.showCapturedImage = true
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    var previewLayer: AVCaptureVideoPreviewLayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


struct CapturedImageView: View {
    var image: UIImage
    @Binding var show: Bool

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                Button(action: {
                    saveImage()
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    show = false
                }) {
                    Text("Dismiss")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    private func saveImage() {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        show = false
    }
}
