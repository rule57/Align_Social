//
//  CameraView2Controller.swift
//  Align
//
//  Created by William Rule on 6/22/24.
//
import UIKit
import AVFoundation

class CameraView2Controller: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var capturePhotoOutput: AVCapturePhotoOutput!
    var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupPreviewLayer()
        setupCapturePhotoOutput()
        setupShutterButton()
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    private func setupCapturePhotoOutput() {
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput.isHighResolutionCaptureEnabled = true
        captureSession.addOutput(capturePhotoOutput)
    }
    
    private func setupShutterButton() {
        let shutterButton = UIButton(type: .system)
        shutterButton.setTitle("Capture", for: .normal)
        shutterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        shutterButton.backgroundColor = .white
        shutterButton.setTitleColor(.black, for: .normal)
        shutterButton.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.height - 300, width: 100, height: 50)
        shutterButton.layer.cornerRadius = 10
        shutterButton.addTarget(self, action: #selector(shutterButtonTapped), for: .touchUpInside)
        
        view.addSubview(shutterButton)
    }
    
    @objc private func shutterButtonTapped() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    private func showCapturedImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.height - 150, width: 100, height: 50)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        imageView.addSubview(saveButton)
    }
    
    @objc private func saveButtonTapped() {
        guard let image = capturedImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        capturedImage = nil
        view.subviews.last?.removeFromSuperview() // Remove the image view with the save button
    }
}

extension CameraView2Controller: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        capturedImage = UIImage(data: imageData)
        if let image = capturedImage {
            showCapturedImage(image)
        }
    }
}

