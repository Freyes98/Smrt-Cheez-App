//
//  SeccionTableViewCell.swift
//  SmrtCheese
//
//  Created by Francisco on 02/08/22.
//

import UIKit

class SeccionCeldaTableViewCell: UITableViewCell {


    @IBOutlet weak var myDescription: UILabel!
    @IBOutlet weak var myApartadoname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
