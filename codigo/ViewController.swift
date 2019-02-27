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
    var testcoords: [CLLocationCoordinate2D] = []

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
        let coords1 = CLLocationCoordinate2D(latitude: 42.846667, longitude: -2.673056) // Vitoria
        let coords2 = CLLocationCoordinate2D(latitude: 40.418889, longitude: -3.691944) // Madrid
        let coords3 = CLLocationCoordinate2D(latitude: 37.383333, longitude: -5.983333) // Sevilla

        testcoords = [coords1, coords2, coords3]

        dibujar()

        determineCurrentLocation() // updating current location method

    }


    //Step 5. Update to current location

    func determineCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }


    //Step 6. Most important thing is to add delegate methods of MKMapView in which we are showing Map region and Polyline

    func dibujar() {
        
        // Dibujar la línea
        let testline = MKPolyline(coordinates: testcoords, count: testcoords.count)
        etiquetaMap.addOverlay(testline)

        // Dibujar las chinchetas
        for each in 0..<testcoords.count {
            let anno = MKPointAnnotation()
            anno.coordinate = testcoords[each]
            etiquetaMap.addAnnotation(anno as MKAnnotation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // Recibir las actualizaciones de posición del GPS y centrar el mapa
        let userLocation: CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)) // Nivel de zoom (estaba a 0.1)
        etiquetaMap.setRegion(region, animated: true)

        //        locationManager.stopUpdatingLocation() // Esto para el GPS, no recibimos más actualizaciones
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

