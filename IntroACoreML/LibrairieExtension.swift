//
//  LibrairieExtension.swift
//  IntroACoreML
//
//  Created by christophe on 27/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoChoisieImageView.image = image
            if let data = UIImagePNGRepresentation(image) {
                requete(data: data)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
