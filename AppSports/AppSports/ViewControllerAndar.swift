//
//  ViewControllerAndar.swift
//  AppSports
//
//  Created by  on 25/1/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerAndar: UIViewController, CLLocationManagerDelegate  {
    
    
    @IBOutlet weak var etiquetaMap: MKMapView!
    let locationManager = CLLocationManager()
    
    //Cronómetro
    var timer = Timer()
    
    var horas = 0
    var minutos = 0
    var segundos = 0
    var tiempo = ""
    
    
    @IBOutlet weak var cronometro: UILabel!//Label cronometro
    
    @IBAction func iniciar(_ sender: Any) {//Botón Iniciar
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewControllerAndar.action) , userInfo: nil, repeats: true)
        
    }
    
    @IBAction func reset(_ sender: Any) {
        cronometro.text = "0"
        segundos = 0
    }
    
    
    @IBAction func pausar(_ sender: Any) {//Botón Pausar
        timer.invalidate()
    }
    
    @objc func action(){
        if (segundos >= 60){
            minutos = minutos + 1
            segundos = 0
        }
        
        if (minutos >= 60){
            horas = horas + 1
            minutos = 0
        }

        segundos += 1
        
        
        
        cronometro.text = String(format: "%02d:%02d:%02d", horas, minutos, segundos)
        
    }
    
    //Fin cronómetro
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        etiquetaMap.showsUserLocation = true
        //Posicion inicial de cronómetro.
        cronometro.text = String(format: "%02d:%02d:%02d", 0, 0, 0)

        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.activityType = .fitness
            locationManager.startUpdatingLocation()
            
        } else {
            print("PLease turn on location services or GPS")
        }
        
    }
    
    // MARK:- CLLocationManager Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.etiquetaMap.setRegion(region, animated: true)
        
        print(locations[0].coordinate.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
