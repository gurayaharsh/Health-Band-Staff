//
//  PatientVitalsViewController.swift
//  Health Band Staff
//
//  Created by Joshua George on 2021-03-22.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit
import MapKit
import Firebase

// custom pin for map view
class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(location:CLLocationCoordinate2D) {
        self.coordinate = location
    }
}

class PatientVitalsViewController: UIViewController {

    let db = Firestore.firestore()
    
    @IBOutlet var patientLocationMapView: MKMapView!
    @IBOutlet var patientTemperature: UILabel!
    @IBOutlet var patientOxygenLevel: UILabel!
    @IBOutlet var patientHeartRate: UILabel!
    @IBOutlet var patientName: UILabel!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPatientVitals()
        patientName.text = "\(name)"
    }
    //.order(by: "created", descending: true)
    func getPatientVitals() {
        db.collection("patients").whereField("name", isEqualTo: "patient1").order(by: "created", descending: true).getDocuments() { (querySnapshot, err) in
               if let err = err {
                          print("Error getting documents: \(err)")
                      }
               else {
                print(querySnapshot!.documents)
                for n in 0...10 {
                    print(querySnapshot!.documents[n].documentID)
                }
                let document = querySnapshot!.documents[0]
                self.patientHeartRate.text = "\(document.get("hr") as! Int) bpm"
                self.patientTemperature.text = "\(document.get("temp") as! Double)°C"
                self.patientOxygenLevel.text = "\(document.get("oxygen") as! Int)%"
                let geolocation = document.get("loc") as! GeoPoint
                let patientLocation = CLLocationCoordinate2D(latitude: geolocation.latitude, longitude: geolocation.longitude)
                let patientRegion = MKCoordinateRegion(center: patientLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                self.patientLocationMapView.setRegion(patientRegion, animated: true)
                let pin = customPin(location: patientLocation)
                self.patientLocationMapView.addAnnotation(pin)
            }
        }
    }

}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
