//
//  LocalCeldaTableViewCell.swift
//  SmrtCheese
//
//  Created by Francisco on 27/07/22.
//

import UIKit

class LocalCeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var MylocalAdress: UILabel!
    @IBOutlet weak var MyLocalname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
