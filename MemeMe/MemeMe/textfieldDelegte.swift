//
//  File.swift
//  MemeMe
//
//  Created by Alireza on 8/26/21.
//


import UIKit

class textFieldDelegate : NSObject , UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
    }
}
