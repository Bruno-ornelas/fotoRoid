//
//  FinalViewController.swift
//  FotoRoid
//
//  Created by Bruno Ornelas on 12/10/20.
//

import UIKit
import Photos

class FinalViewController: UIViewController {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    func saveToAlbum() {
        PHPhotoLibrary.shared().performChanges ({
            
            let createRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([createRequest.placeholderForCreatedAsset as Any] as NSArray)


        }) { (success, error) in
            if !success {
                print(error!.localizedDescription)
            } else {
                let alert = UIAlertController(title: "imagem salva", message: "Sua imagem foi salva", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
                        
        }

    }
    
    @IBAction func save(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.saveToAlbum()
            default:
                let alert = UIAlertController(title: "ERRO", message: "você precisa autorizar o acesso ao album", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    @IBAction func restart(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    


}
