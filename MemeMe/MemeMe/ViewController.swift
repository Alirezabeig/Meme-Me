//
//  ViewController.swift
//  MemeMe
//
//  Created by Alireza on 8/17/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareB: UIButton!
    @IBOutlet weak var camera: UIBarButtonItem!
    
    let shareImage = UIImagePickerController()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: UIBarButtonItem) {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func trybutton(_ sender: UIButton) {
        let shareB = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        shareB.popoverPresentationController?.sourceView = self.view
        present(shareB, animated: true, completion: nil)
    }
}

