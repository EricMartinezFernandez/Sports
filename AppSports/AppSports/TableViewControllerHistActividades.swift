//
//  TableViewControllerHistActividades.swift
//  AppSports
//
//  Created by  on 30/1/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import Firebase
import Eureka



class TableViewControllerHistActividades: UITableViewController {

    //Estruct Actividad
    struct Actividad {
        var fecha: String
        var activity: String
        var duracion: String
        var distancia: String
        var coor: Array<GeoPoint> = []
    }


    //Lista de actividades
    var listaActividad: [Actividad] = []

    //var person1: Actividad = Actividad(fecha: "1", actividad: "2", duracion: "3", distancia: "1")
    //var person2: Actividad = Actividad(fecha: "3", actividad: "4", duracion: "3", distancia: "1")





    override func viewDidLoad() {
        super.viewDidLoad()

        //Auth.auth().signInAnonymously() { (user, error) in

        // UID de usuario asignado por Firebase
        //let uid = user!.uid
        //log.debug("Usuario: \(uid)")

        db.collection("actividades").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                log.error("Error al recuperar documentos: \(error!)")
                return
            }

            /*db.collection("actividades").whereField("propietario", isEqualTo: uid)
                .addSnapshotListener { querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        log.error("Error al recuperar documentos: \(error!)")
                        return
                    }*/

            // Limpiar el array de objetos
            self.listaActividad.removeAll()

            for document in documents {
                
                // Recuperar los datos de la lista y crear el objeto
                let datos = document.data()
                
                let act = datos["actividad"] as? String ?? "?"
                let distancia = datos["distancia"] as? String ?? "?"
                let duracion = datos["duración"] as? String ?? "?"
                let fecha = datos["fecha"] as? String ?? "?"
                let cord = datos["coordenadas"] as? Array<GeoPoint> 
                
               

                let lista: Actividad = Actividad(fecha: fecha, activity: act, duracion: duracion, distancia: distancia, coor: cord!)


                self.listaActividad.append(lista)
                
                
                
            }

            // Recargar la tabla
            self.tableView.reloadData()

            //}

        }


        //listaActividad.append(person1)
        //listaActividad.append(person2)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

        //Permite ativar editar las celdas para borrar la actividad
        self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return listaActividad.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaItemLista", for: indexPath) as! ItemTableViewCell
        
        cell.etiquetaFecha.text = listaActividad[indexPath.row].fecha
        cell.etiquetaDistancia.text = listaActividad[indexPath.row].distancia
        cell.etiquetaDuracion.text = listaActividad[indexPath.row].duracion
        cell.etiquetaActividad.text = listaActividad[indexPath.row].activity

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "identificadordetalle" {
            
            
            
            let pathRow = tableView.indexPathForSelectedRow
            let selectedRow = pathRow!.row
            
            let destino = segue.destination as? DetalleActividadViewController
            
            print(selectedRow)
            
            
            
            let fech = listaActividad[selectedRow].fecha
            let dist = listaActividad[selectedRow].distancia
            let dur = listaActividad[selectedRow].duracion
            let nameAct = listaActividad[selectedRow].activity
            var co: Array<GeoPoint> = listaActividad[selectedRow].coor
           
            
            
            destino?.f = fech
            destino?.d = dist
            destino?.nom = nameAct
            destino?.dur = dur
            destino?.coordenadas = co
            
            
        }
        
        
    }
    

}
