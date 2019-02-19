//
//  TableViewControllerHistActividades.swift
//  AppSports
//
//  Created by  on 30/1/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit

class TableViewControllerHistActividades: UITableViewController {
    
    
    struct Actividad {
        var fecha: String
        var actividad: String
        var duracion: String
        var distancia: String
    }



  


    //Lista de actividades
    var listaActividad: [Actividad] = []
    
    var person1: Actividad = Actividad(fecha:"1", actividad:"2", duracion:"3", distancia:"1")

    


    override func viewDidLoad() {
        super.viewDidLoad()

        listaActividad.append(person1)


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
