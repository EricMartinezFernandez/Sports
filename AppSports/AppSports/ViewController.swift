//
//  ViewController.swift
//  AppSports
//
//  Created by  on 23/1/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
      let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
                print("location:: (location)")
            }
        }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: (error)")
        }
    }
    
    




