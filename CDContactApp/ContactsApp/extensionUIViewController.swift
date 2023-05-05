//
//  extensionUIViewController.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 15/03/23.
//

import Foundation
import UIKit

//MARK: Keyboard Handling extension
extension UIViewController{
    
    func hideKeyBoardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
