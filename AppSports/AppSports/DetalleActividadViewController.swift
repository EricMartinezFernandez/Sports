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

class DetalleActividadViewController: UIViewController {

    @IBOutlet weak var etiquetaNombreActividad: UILabel!
    @IBOutlet weak var etiquetaDuracion: UILabel!
    @IBOutlet weak var etiquetafecha: UILabel!
    @IBOutlet weak var etiquetaDistancia: UILabel!
    
    var f:String = ""
    var d:String = ""
    var nom:String = ""
    var dur:String = ""
    var coordenadas: Array<GeoPoint> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etiquetaDistancia.text = d
        etiquetaNombreActividad.text = nom
        etiquetaDuracion.text = dur
        etiquetafecha.text = f

        // Do any additional setup after loading the view.
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
