//
//  SensorValuesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit
import Alamofire
import Foundation

class SensorValuesViewController: UIViewController {

    var sensor: Sensor?
    var tkn: Token?
    
    @IBOutlet weak var sensor_img: UIImageView!
    @IBOutlet weak var name_sensor: UILabel!
    
    @IBOutlet weak var value_sensor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        self.tkn = Token(type: nil, token: token)
        
        self.value_sensor.text = "Leyendo datos..."
        
        name_sensor.text = sensor?.nombreSensor
        
        if sensor?.tipo == "ultrasonico"{
            sensor_img.image = UIImage(named: "Ultrasonico.png")
        }
        
        else if sensor?.tipo == "temperatura"{
            sensor_img.image = UIImage(named: "Temperatura.png")
        }
        else if sensor?.tipo == "flama"{
            sensor_img.image = UIImage(named: "Flama.png")
        }
        else if sensor?.tipo == "humo"{
            sensor_img.image = UIImage(named: "humo.png")
        }
        else if sensor?.tipo == "infrarojo"{
            sensor_img.image = UIImage(named: "Infrarrojo.png")
        }
        
        
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(SensorValuesViewController.sayHello), userInfo: nil, repeats: true)

        
        
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor: (sensor?.id)!){(result) in
            switch result {
            case .success(let json):
                
                if (json != nil){
                    self.value_sensor.text = "\(Int((json as! Value).value))"
                }
                else {
                    self.value_sensor.text = "N/A"
                }
                
    
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
    
}
    
    

    @objc func sayHello()
    {
        
        //name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor: (sensor?.id)!){(result) in
            switch result {
            case .success(let json):
                
                if (json != nil){
                    self.value_sensor.text = "\(Int((json as! Value).value))"
                }
                else {
                    self.value_sensor.text = "N/A"
                }
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
    }
    
    
    @IBAction func Actualizar(_ sender: Any) {
        
        
        name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor:(sensor?.id)!){(result) in
            switch result {
            case .success(let json):
                
                self.value_sensor.text = "\(Int((json as! Value).value))"
    
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
        
    }
}
