//
//  HistorialCeldaTableViewCell.swift
//  SmrtCheese
//
//  Created by Francisco on 17/08/22.
//

import UIKit

class HistorialCeldaTableViewCell: UITableViewCell {
    @IBOutlet weak var Fecha: UILabel!
    
    @IBOutlet weak var Valor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
