//
//  ViewController.swift
//  IntroACoreML
//
//  Created by christophe on 27/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var cameraVue: UIView!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var photoChoisieImageView: UIImageView!
    
    @IBOutlet weak var librairie: UIButton!
    @IBOutlet weak var rotationBouton: UIButton!
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var captureVideoCapturePreviewLayer: AVCaptureVideoPreviewLayer?
    var position = AVCaptureDevice.Position.back
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlaceCamera()
        rotationBouton.layer.cornerRadius = 5
        librairie.layer.cornerRadius = 5
        imagePicker.delegate = self
    }
    
    @IBAction func rotationAction(_ sender: Any) {
        switch position {
        case .front:
            position = .back
        case .back:
            position = .front
        case .unspecified:
            position = .back
        }
        miseEnPlaceCamera()
    }
    @IBAction func librairieAction(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

