//
//  DashboardViewController.swift
//  Health Band Staff
//
//  Created by Harsh  on 2021-01-13.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit
import Firebase

class DashBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var patientTableView: UITableView!
    let myData = ["first", "second", "third", "fourth", "fifth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DashBoard"
        navigationItem.hidesBackButton = true
        
        // setting background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        
        // Patient Table
        let nib = UINib(nibName: "PatientTableViewCell", bundle: nil)
        patientTableView.register(nib, forCellReuseIdentifier: "PatientTableViewCell")
        patientTableView.delegate = self
        patientTableView.dataSource = self
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print (signOutError)
        }
          
    }
    
    // TableView Funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        cell.myLabel.text = myData[indexPath.row]
        return cell
    }
}
