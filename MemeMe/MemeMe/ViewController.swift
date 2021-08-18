//
//  ViewController.swift
//  MemeMe
//
//  Created by Alireza on 8/17/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {


    @IBOutlet weak var imagePreview: UIImageView!
    let pickerImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        pickerImage.allowsEditing = true
        pickerImage.delegate = self
        pickerImage.sourceType = .photoLibrary
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            pickerImage.mediaTypes = mediaTypes
               }
               present(pickerImage, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePreview.image = image
        }

        self.pickerImage.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
        imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            
    }
    
}

