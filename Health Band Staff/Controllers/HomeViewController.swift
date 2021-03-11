//
//  HomeViewController.swift
//  Health Band Staff
//
//  Created by Harsh  on 2021-01-12.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.showAlert(title: "Error", message: "Unable to Login")
                }
                else{
                    self.performSegue(withIdentifier: "HomeToDashboard", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDashboard" {
            let vc = segue.destination as! DashBoardViewController
            let staffEmail = emailTextField.text
            vc.staffEmail = staffEmail!
        }
    }
    
    func showAlert(title: String, message: String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
   
}
