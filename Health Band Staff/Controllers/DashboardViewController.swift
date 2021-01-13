//
//  DashboardViewController.swift
//  Health Band Staff
//
//  Created by Harsh  on 2021-01-13.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit
import Firebase

class DashBoardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DashBoard"
        navigationItem.hidesBackButton = true
    }
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print (signOutError)
        }
          
    }
}
