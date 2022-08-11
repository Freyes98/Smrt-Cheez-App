//
//  UpdateSensorViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class UpdateSensorViewController: UIViewController {

    var sensor : Sensor?
    
    @IBOutlet weak var name_sensor: UITextField!
    @IBOutlet weak var tipo_sensor: UITextField!
    @IBOutlet weak var pines: UITextField!
    @IBOutlet weak var descripcion_sensor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateAction(_ sender: Any) {
        
        
    }
    

}
