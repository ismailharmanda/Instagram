//
//  ViewController.swift
//  Instagram
//
//  Created by ismail harmanda on 6.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onPressSignIn(_ sender: UIButton) {
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    
    @IBAction func onPressSignUp(_ sender: UIButton) {
    }
    
}

