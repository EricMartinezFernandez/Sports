//
//  DetalleActividadViewController.swift
//  AppSports
//
//  Created by  on 20/2/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class DetalleActividadViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var etiquetaMapView: MKMapView!
    
   
    
    //Variable CllocationManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var etiquetaNombreActividad: UILabel!
    @IBOutlet weak var etiquetaDuracion: UILabel!
    @IBOutlet weak var etiquetafecha: UILabel!
    @IBOutlet weak var etiquetaDistancia: UILabel!
    
    var f:String = ""
    var d:String = ""
    var nom:String = ""
    var dur:String = ""
    var coordenadas: Array<GeoPoint> = []
    
    var arrayCllocation : Array<CLLocationCoordinate2D> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etiquetaDistancia.text = d
        etiquetaNombreActividad.text = nom
        etiquetaDuracion.text = dur
        etiquetafecha.text = f
        
        etiquetaMapView.delegate = self
        
        for punto in coordenadas {
            arrayCllocation.append(CLLocationCoordinate2D(latitude: punto.latitude,longitude: punto.longitude))
            
        }
        
        
        for j in arrayCllocation {
            
    
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: j.latitude, longitude: j.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
            self.etiquetaMapView.setRegion(region, animated: true)
            
            //Variable Mkpolyline para pintar la linea
            let annotation2 = MKPolyline(coordinates:arrayCllocation,count:arrayCllocation.count)
            
            etiquetaMapView.addOverlay(annotation2)
            
        }
        
        
        
    
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
