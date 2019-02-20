//
//  ItemTableViewCell.swift
//  AppSports
//
//  Created by  on 14/2/19.
//  Copyright © 2019 EricJose. All rights reserved.
//

import UIKit
import Firebase

class ItemTableViewCell: UITableViewCell {

    //Etiquetas de acceso a los labels
    @IBOutlet weak var etiquetaFecha: UILabel!
    @IBOutlet weak var etiquetaActividad: UILabel!
    @IBOutlet weak var etiquetaDistancia: UILabel!
    @IBOutlet weak var etiquetaDuracion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
