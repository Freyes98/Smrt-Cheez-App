//
//  SensorValuesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class SensorValuesViewController: UIViewController {

    var sensor: Sensor?
    
    @IBOutlet weak var sensor_img: UIImageView!
    @IBOutlet weak var name_sensor: UILabel!
    
    @IBOutlet weak var value_sensor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
    }
    



}
