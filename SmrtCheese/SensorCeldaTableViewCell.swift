//
//  SensorCeldaTableViewCell.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class SensorCeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var img_sensor: UIImageView!
    @IBOutlet weak var tipo_sensor: UILabel!
    @IBOutlet weak var name_sensor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
