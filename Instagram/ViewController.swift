//
//  ViewController.swift
//  Instagram
//
//  Created by ismail harmanda on 6.11.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }


    @IBAction func onPressSignIn(_ sender: UIButton) {
        
        let auth = Auth.auth()
        
        auth.signIn(withEmail: emailText.text ?? "", password: passwordTextField.text ?? "") { result, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else{
                self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
            }
        }
    }
    
    
    @IBAction func onPressSignUp(_ sender: UIButton) {
        
       let auth = Auth.auth()
        
        if (emailText.text == "" || passwordTextField.text == ""){
            
            makeAlert(title: "Error", message: "email or password can not be empty")
            
            return
        }

        
        auth.createUser(withEmail: emailText.text!, password: passwordTextField.text!) { result, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else{
                self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
            }
        }
        
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
    
    
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { action in
            alert.dismiss(animated: true)
        }
    
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
    
}

