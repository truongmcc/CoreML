//
//  CameraExtension.swift
//  IntroACoreML
//
//  Created by christophe on 27/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension ViewController : AVCapturePhotoCaptureDelegate {
    func miseEnPlaceCamera() {
        captureVideoCapturePreviewLayer?.removeFromSuperlayer()
        captureSession = AVCaptureSession()
        if captureSession != nil {
            if let appareil = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: position) {
                do {
                    let input = try AVCaptureDeviceInput(device: appareil)
                    if captureSession!.canAddInput(input) {
                        captureSession!.addInput(input)
                        capturePhotoOutput = AVCapturePhotoOutput()
                        if capturePhotoOutput != nil {
                            if captureSession!.canAddOutput(capturePhotoOutput!) {
                                captureSession!.addOutput(capturePhotoOutput!)
                                captureVideoCapturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                                captureVideoCapturePreviewLayer?.videoGravity = .resizeAspectFill
                                captureVideoCapturePreviewLayer?.connection?.videoOrientation = .portrait
                                if captureVideoCapturePreviewLayer != nil {
                                    captureVideoCapturePreviewLayer?.frame = cameraVue.bounds
                                    cameraVue.layer.addSublayer(captureVideoCapturePreviewLayer!)
                                    cameraVue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prendrePhoto)))
                                    captureSession!.startRunning()
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func prendrePhoto() {
        if capturePhotoOutput != nil {
            capturePhotoOutput?.capturePhoto(with: obtenirReglages(), delegate: self)
        }
    }
    
    func obtenirReglages() -> AVCapturePhotoSettings {
        let reglages = AVCapturePhotoSettings()
        reglages.previewPhotoFormat = reglages.embeddedThumbnailPhotoFormat
        return reglages
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error == nil {
            if let data = photo.fileDataRepresentation() {
                photoChoisieImageView.image = UIImage(data: data)
                requete(data: data)
            } else {
                print("le résultat ne donne pas de Data")
            }
        } else {
            print(error!.localizedDescription)
        }
    }
}
