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
    
    let db = Firestore.firestore()
    var staffEmail: String = ""
    var patientList: [String] = []

    @IBOutlet var patientTableViewBorder: UIView!
    @IBOutlet var patientTableView: UITableView!
    @IBOutlet var patientTitle: UILabel!
    @IBAction func addPatientButton(_ sender: Any) {
    }
    @IBAction func removePatientButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        title = "DashBoard"
        navigationItem.hidesBackButton = true
        
        // Patient Table
        let nib = UINib(nibName: "PatientTableViewCell", bundle: nil)
        patientTableView.register(nib, forCellReuseIdentifier: "PatientTableViewCell")
        patientTableView.delegate = self
        patientTableView.dataSource = self
        patientTableViewBorder.backgroundColor = UIColor.clear
        patientTableViewBorder.layer.borderColor = UIColor.white.cgColor
        patientTableViewBorder.layer.cornerRadius = 8
        patientTableViewBorder.layer.borderWidth = 3
        getPatientList()
               
    }
    
    func getPatientList() {
        db.collection("staff").whereField("email", isEqualTo: staffEmail).getDocuments() { (querySnapshot, err) in
               if let err = err {
                          print("Error getting documents: \(err)")
                      }
               else {
                let document = querySnapshot!.documents[0]
                          self.patientList = document.get("patients") as! [String]
                DispatchQueue.main.async {
                    self.patientTableView.reloadData()
                }
                
            }
        }
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

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    // TableView Funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        cell.myLabel.text = patientList[indexPath.row]
        cell.roundView.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PatientController") as? PatientVitalsViewController
        vc!.name = patientList[indexPath.row]
        print(vc!.name)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5
        return cellSpacingHeight
    }
}
