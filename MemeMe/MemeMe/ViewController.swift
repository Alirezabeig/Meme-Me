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
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var bottomTexField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
    }
    
    // Pick image from album
    @IBAction func btnImagePicker(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        
    }
    
    
    // Pick image from camera
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present( imagePicker, animated: true)
    }
    
    // Display the taken or picked image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        imageView.image = image
        
        dismiss(animated: true)
    }
    
    // Be notificed when the keyboard appears
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // When shift the view's frame up, keyboardWillShow notification is received.
    @objc func keyboardWillShow(_ notification:Notification) {

        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 3 ,
    ]

    // Set the attribute of the texfield
    func attributes(textField: UITextField)
    {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextField.BorderStyle.none
    }
    
    // meme struct
    struct Meme {
        var topFieldText: String
        var bottomFieldText: String
        var Image: UIImage
        var meme: UIImage
        
    }
    // Generate Meme
    func generateMeme () -> UIImage {
        
        self.toolBar.isHidden = true
        self.navBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
            let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            //Show tool and nav bars
        self.toolBar.isHidden = false
        self.navBar.isHidden = false


            return memedImage
        
    }
    
    // Save Created Meme
    func saveMeme() {
        
        let memedImage = generateMeme()
        
        _ = Meme(topFieldText:  topTextField.text! , bottomFieldText: bottomTexField.text! , Image: imageView.image! , meme: memedImage )
    }

    
    // Share The Created Meme
    @IBAction func sharButtonPressed(_ sender: Any) {
        
        let meme = generateMeme()
        let controller = UIActivityViewController (activityItems: [meme], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, completed, items , error in if completed {
            self.saveMeme()
            self.dismiss(animated: true, completion: nil)
            }
        
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    // Cancel all actions -
    @IBAction func cancelButton(_ sender: Any) {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTexField.text = "BOTTOM"
        shareButton.isEnabled = false
    }
    
    
}


