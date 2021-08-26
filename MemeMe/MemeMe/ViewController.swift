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
    
    var image : UIImage?
    
    let shareImage = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnImagePicker(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        imageView.image = image
        
        dismiss(animated: true)
    }
    

    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present( imagePicker, animated: true)
      
    }
    
}

