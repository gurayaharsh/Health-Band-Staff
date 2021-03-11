//
//  RegisterViewController.swift
//  Health Band Staff
//
//  Created by Harsh  on 2021-01-12.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func registerPressed(_ sender: UIButton) {
        
        // toDo: set custom requirements
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.showAlert(title: "Error", message: "Unable to Register")
                    
                }
                else {
                    self.performSegue(withIdentifier: "RegisterToDashboard", sender: self)
                }
            }
        }
        
       
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterToDashboard" {
            let vc = segue.destination as! DashBoardViewController
            let staffEmail = emailTextField.text
            vc.staffEmail = staffEmail!
        }
    }
    }

