//
//  SensorValuesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit
import Alamofire
class SensorValuesViewController: UIViewController {

    var sensor: Sensor?
    
    @IBOutlet weak var sensor_img: UIImageView!
    @IBOutlet weak var name_sensor: UILabel!
    
    @IBOutlet weak var value_sensor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        
        name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: tkn, id_sensor: "62f2f560eb0eb706a86922c6"){(result) in
            switch result {
            case .success(let json):
                
                self.value_sensor.text = "\(Int((json as! Value).value))"
                //let tkn = (json as! ResponseProfile).email
                //let value = (json as! Value)
                //Apartados = json as! [Seccion]
                //print(countt)
                
                
                //Guardado de datos
                //rint(json.publisher.last())
                
    
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
    



}
    @IBAction func Actualizar(_ sender: Any) {
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        
        name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: tkn, id_sensor: "62f2f560eb0eb706a86922c6"){(result) in
            switch result {
            case .success(let json):
                
                
                self.value_sensor.text = "\(Int((json as! Value).value))"

                
    
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
        
    }
}
