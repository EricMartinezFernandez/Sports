//
//  ViewController.swift
//  mapaLinea
//
//  Created by Sofía Juarez Gonzalez on 23/2/19.
//  Copyright © 2019 armas jose. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//Paso 1 delegates
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    //Acceso al mapView
    @IBOutlet weak var etiquetaMap: MKMapView!
    
    
    //Paso 2
    var locationManager = CLLocationManager()
    var testcoords:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Set up LocationManager and MapView
    func setUp() {
        // location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //Map view settings
        etiquetaMap.delegate = self
        etiquetaMap.mapType = MKMapType.standard
        etiquetaMap.isZoomEnabled = true
        etiquetaMap.isScrollEnabled = true
        etiquetaMap.center = view.center
        // adding co-ordinates for poly line (added static, we can make it dyanamic)
        let coords1 = CLLocationCoordinate2D(latitude: 21.1233668, longitude: 79.1027889)
        let coords2 = CLLocationCoordinate2D(latitude: 21.122083, longitude: 79.1135274)
        let coords3 = CLLocationCoordinate2D(latitude: 21.1235418, longitude: 79.1150327)
        let coords4 = CLLocationCoordinate2D(latitude: 21.1384636, longitude: 79.1189755)
        testcoords = [coords1,coords2,coords3,coords4]
        determineCurrentLocation() // updating current location method
    }
    
    
    //Step 5. Update to current location
    
    func determineCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    //Step 6. Most important thing is to add delegate methods of MKMapView in which we are showing Map region and Polyline
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // adding map region
        let userLocation:CLLocation = locations[0] as CLLocation
        let testline = MKPolyline(coordinates: testcoords, count: testcoords.count)
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        
        
        // adding annotation aat particular point
        for each in 0..<testcoords.count{
            let anno = MKPointAnnotation()
            anno.coordinate = testcoords[each]
            etiquetaMap.addAnnotation(anno as MKAnnotation)
        }
        etiquetaMap.setRegion(region, animated: true)
        etiquetaMap.addOverlay(testline)
        locationManager.stopUpdatingLocation()
    }
    
    
    //Adding polyline
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if let polyline = overlay as? MKPolyline {
        let testlineRenderer = MKPolylineRenderer(polyline: polyline)
        testlineRenderer.strokeColor = .blue
        testlineRenderer.lineWidth = 2.0
        return testlineRenderer
    }
        
        fatalError("Something wrong...")
    }
    
    


}

