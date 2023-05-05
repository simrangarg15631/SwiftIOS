//
//  ViewController.swift
//  TaskOne
//
//  Created by Saheem Hussain on 15/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    #warning("outlet names should be proper")
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUP: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text=""
        signIn.layer.cornerRadius=8
        signUP.layer.cornerRadius=8
        
    }


    @IBAction func signInButton(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text{
            if email=="" || password==""{
                resultLabel.text="Fill in the credentials"
                resultLabel.textColor = .systemRed
            }else{
                if isvalidEmail(email) && isvalidPassword(password){
                    resultLabel.text="Login succesful!!!"
                    resultLabel.textColor = .systemGreen
                }else{
                    #warning("validation methods should be proper. User won't find out unless you tell them exactly what are you expecting from them.")
                    resultLabel.text="Invalid Email and Password"
                    resultLabel.textColor = .systemRed
                }
            }
        }
        
    }
}

#warning("Validation methods should be in different file to maintain reusability")
func isvalidEmail(_ email:String)->Bool{
    // One or more characters followed by an "@",
    // then one or more characters followed by a ".",
    // and finishing with one or more characters
    let emailPattern = #"^\S+@\S+\.\S+$"#
    let result = email.range(
        of: emailPattern,
        options: .regularExpression
    )
    return result != nil
}

func isvalidPassword(_ password:String)->Bool{
    let passwordPattern =
        // At least 8 characters
        #"(?=.{8,})"# +

        // At least one capital letter
        #"(?=.*[A-Z])"# +
            
        // At least one lowercase letter
        #"(?=.*[a-z])"# +
            
        // At least one digit
        #"(?=.*\d)"# +
            
        // At least one special character
        #"(?=.*[ !@/#$%&?._-])"#
    
    let result = password.range(
        of: passwordPattern,
        options: .regularExpression
    )

    return result != nil
}
