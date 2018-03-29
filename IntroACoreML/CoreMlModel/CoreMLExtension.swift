//
//  CoreMLExtension.swift
//  IntroACoreML
//
//  Created by christophe on 27/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
// COURS SYMPA :
// https://medium.com/@hunter.ley.ward/ml-on-ios-running-coreml-on-ios-f9cb340f3855


import UIKit
import CoreML
import Vision

extension ViewController {
    
    func requete(data: Data) {
        do {
            // 1) creation du moedèle
            // Vision va créer le modèle via le modèle MobuleNet
            let coreMLModel = try VNCoreMLModel(for: MobileNet().model)
            
            // 2) création et exécution de la requête
            // VNCoreMLRequest est une requête sur l'analyse d'image qui utilise le modèle CoreML
            let requete = VNCoreMLRequest(model: coreMLModel, completionHandler: reponse)
            // VNImageRequestHandler : objet qui traite une ou plusieurs demandes d'analyse d'image appartenant à une seule image.
            let requeteHandler = VNImageRequestHandler(data: data)
            try requeteHandler.perform([requete])
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func reponse (_ requete: VNRequest, _ erreur: Error?) {
        // VNClassificationObservation est la classification des résultats de la requete
        if let result = requete.results as? [VNClassificationObservation] {
            for res in result {
                print(res.identifier)
                print(Int(res.confidence * 100))
            }
            let resultats = result.sorted(by: {$0.confidence > $1.confidence})
            if resultats.count > 0 {
                let meilleurResultat = resultats[0]
                let attributed = NSMutableAttributedString(string: meilleurResultat.identifier, attributes:[.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.red])
                predictionLabel.attributedText = attributed
                let int = Int(meilleurResultat.confidence * 100)
                let confianceString = "\n Confiance : " + String(int) + "%"
                attributed.append(NSMutableAttributedString(string: confianceString, attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black]))
                predictionLabel.attributedText = attributed
            }

        }
    }
}
