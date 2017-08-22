//
//  ViewController.swift
//  Meme
//
//  Created by James Luo on 22/8/17.
//  Copyright © 2017 James Luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }


    enum ImageSourceType: Int {
        case fromCamera = 0
        case fromLibrary
        
        func toUIImagePickerControllerSourceType() -> UIImagePickerControllerSourceType {
            switch self {
            case .fromCamera:
                return UIImagePickerControllerSourceType.camera
            case .fromLibrary:
                return UIImagePickerControllerSourceType.photoLibrary
            }
        }
    }
    
    @IBAction func pickAnImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = ImageSourceType(rawValue: sender.tag)!.toUIImagePickerControllerSourceType()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

