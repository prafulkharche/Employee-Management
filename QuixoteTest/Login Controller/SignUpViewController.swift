//
//  SignUpViewController.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 06/04/22.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var mobText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    //MARK: ViewLifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mobText.delegate = self
        passwordText.delegate = self
    }
    
    //MARK: Functional Methods
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"//{2,64}
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidateMobile(mobile: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(91))[0-9]{6,14}$"//10
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: mobile)
        return result
    }
    
    func presentAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func isValidPassword(password:String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9]).{8,15}$"
        
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
   //MARK: IBActtion Methods
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if (isValidEmail(email: emailText.text ?? "")) && (isValidateMobile(mobile: mobText.text ?? "")) && isValidPassword(password: passwordText.text ?? "") && (passwordText.text?.contains(nameText.text ?? "") == false){
            let modelInfo = LoginData(name: nameText.text ?? "", mob: mobText.text ?? "", email: emailText.text ?? "", password: passwordText.text ?? "")
            
            let isSave = DatabaseManager.shared.saveLoginData(modelInfo)
            print(isSave)
            
            presentAlert(title: "Success", message: "You have SignUp sucessfully")
            dismiss(animated: true){
                self.navigationController?.popViewController(animated: true)
            }
            
        }else{
            if isValidEmail(email: emailText.text ?? "") == false {
                presentAlert(title: "Invalid", message: "Please enter correct Email address")
            }else if isValidateMobile(mobile: mobText.text ?? "") == false{
                presentAlert(title: "Invalid", message: "Please enter correct  mobile number")
            }else if isValidPassword(password: passwordText.text ?? "") == false || ((passwordText.text?.contains(nameText.text ?? "")) == true){
                presentAlert(title: "Invalid", message: "Please enter paswword should contain 8 charcters 1 special charcter 2 uppercase , 2 digit and must be start with lowercase letter")
            }else{
                
                presentAlert(title: "Warning", message: "Invalid Data")
            }
        }
        
    }
    
    //MARK: TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength : Int?
        if textField == mobText{
            maxLength = 12
        }else{
            maxLength = 16
        }
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
    }
}
