//
//  ViewControllerCorrer.swift
//  AppSports
//
//  Created by  on 25/1/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class ViewControllerCorrer: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    

    //Variables con las que guardamos los datos en Firebase
    var arrayCoordenadas: Array<CLLocationCoordinate2D> = []
    var coordenadas: Array<GeoPoint> = []
    var distancia = ""
    var fecha = "ayer"
    var act = "correr"
    var duracion = ""

    //Etiqueta de acceso al MkmapView
    @IBOutlet weak var etiquetaMap: MKMapView!
    
    //Variable CllocationManager()
    let locationManager = CLLocationManager()
    
    //Cronómetro
    
    var timer = Timer()
    var horas = 0
    var minutos = 0
    var segundos = 0
    var tiempo = ""
    
    @IBOutlet weak var cronometro: UILabel!
    
    @IBAction func iniciar(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewControllerAndar.action) , userInfo: nil, repeats: true)
    }
    
    @IBAction func pausar(_ sender: Any) {
           timer.invalidate()
    }
    
    @IBAction func reset(_ sender: Any) {
        cronometro.text = "0"
        segundos = 0
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
        duracion = String(format: "%02d:%02d:%02d", horas, minutos, segundos)
    }
    
    //Fin Cronómetro
    
    
    //Accion del boton guardarDatos
    @IBAction func etiquetaBotonGuardarDatos(_ sender: Any) {
        
    
        for punto in arrayCoordenadas {
            coordenadas.append(GeoPoint(latitude: punto.latitude,longitude: punto.longitude))
        }
        
        //Guardar datos en Firestore Add a new document with a generated ID
         var ref: DocumentReference? = nil
         ref = db.collection("actividades").addDocument(data: [
         "actividad": act,
         "coordenadas": coordenadas,
         "distancia": distancia,
         "duración": duracion,
         "fecha": fecha,
         ]) { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
            
         }
         }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        etiquetaMap.showsUserLocation = true
        
        etiquetaMap.delegate = self

        
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
        
        //Agregar un punto en el mapa
        //let annotation = MKPointAnnotation()
        //annotation.title = "Jose"
        
        //Relleno el array de coordenadas
        arrayCoordenadas.append(locations[0].coordinate)
        
        //Variable Mkpolyline para pintar la linea
        let annotation2 = MKPolyline(coordinates:arrayCoordenadas,count:arrayCoordenadas.count)

        etiquetaMap.addOverlay(annotation2)
        
        
        //annotation.coordinate = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        //Mediante la etiquetaMap añado la anotacion
        //etiquetaMap.addAnnotation(annotation)
        
        //arrayCoordenadas.append(CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude))
        
        print(locations[0].coordinate.longitude)
        print("-----")
        print(locations[0].coordinate.latitude)
        
        
       
        
        
        //Calcular la distancia
        // You first have to get the corner point and convert it to a coordinate
        /*let mkmaprect = MKMapRect()
        mkmaprect = self.etiquetaMap.visibleMapRect;
        MKMapPoint cornerPointNW = MKMapPointMake(mapRect.origin.x, mapRect.origin.y);
        CLLocationCoordinate2D cornerCoordinate = MKCoordinateForMapPoint(cornerPointNW);
        
        // Then get the center coordinate of the mapView (just a shortcut for convenience)
        CLLocationCoordinate2D centerCoordinate = self.mapView.centerCoordinate
        
        // And then calculate the distance
        CLLocationDistance distance = [cornerCoordinate distanceFromLocation:centerCoordinate];*/
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //Return an `MKPolylineRenderer` for the `MKPolyline` in the `MKMapViewDelegate`s method
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        fatalError("Something wrong...")
        //return MKOverlayRenderer()
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
