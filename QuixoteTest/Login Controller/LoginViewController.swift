//
//  LoginViewController.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 06/04/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mobEmailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    var loginArray = [LoginData]()
    
    // MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .clear
        //mobEmailText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFiledClearData()
        loginArray =  DatabaseManager.shared.getLoginData()
    }
    
    //MARK: Functional Methods
    func textFiledClearData(){
        mobEmailText.text = ""
        passwordText.text = ""
    }
    
    func presentAlert(){
        let alert = UIAlertController(title: "Inavlid User", message: "You Need to signUp first", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    //MARK: IBAction Methods
    @IBAction func loginButtonClicked(_ sender: Any) {
        if loginArray.contains(where: {($0.email == mobEmailText.text ||  $0.mob == mobEmailText.text ) && $0.password == passwordText.text}) {
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"NotesTableViewController") else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            
            presentAlert()
        }
    }
    
    @IBAction func SignUpButtonClicked(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"SignUpViewController") else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: TextField Delegate Methods
//extension LoginViewController: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool
//    {
//        let maxLength = 12
//        let currentString: NSString = (textField.text ?? "") as NSString
//        let newString: NSString =
//        currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//    }
//}
