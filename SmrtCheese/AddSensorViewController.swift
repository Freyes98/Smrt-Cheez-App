//
//  AddSensorViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class AddSensorViewController: UIViewController {

    var id_seccion: String?
    var array_pines: [Int] = []
    
    @IBOutlet weak var tipo_sensor: UITextField!
    @IBOutlet weak var name_sensor: UITextField!

    @IBOutlet weak var pin1: UITextField!
    
    @IBOutlet weak var pin2: UITextField!
    
    
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var descripcion_sensor: UITextField!
    let imagen = "Sin link"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        pin1.text="0"
        pin2.text="0"
        pin3.text="0"
        // Do any additional setup after loading the view.
    }
    
  
    
    
    @IBAction func AddSensor_Action(_ sender: Any) {
        let datos = UserDefaults.standard
        let tkn = datos.value(forKey: "token") as? String
        
        guard let nombre = name_sensor.text,
              let descripcion = descripcion_sensor.text,
              let tipo = tipo_sensor.text,
              let pin_1 = Int(pin1.text ?? ""),
              let pin_2 = Int(pin2.text ?? ""),
              let pin_3 = Int(pin3.text ?? "")
                
        else {
            return
        }
        
        
        if (pin_1 != 0 && pin_2 == 0 && pin_3 == 0){
            array_pines = []
            array_pines.append(pin_1)
        }
        else if (pin_1 != 0 && pin_2 != 0 && pin_3 == 0){
            array_pines = []
            array_pines.append(pin_1)
            array_pines.append(pin_2)
        }
        
        else if (pin_1 != 0 && pin_2 != 0 && pin_3 != 0){
            array_pines = []
            array_pines.append(pin_1)
            array_pines.append(pin_2)
            array_pines.append(pin_3)
        }
        
        let sensor = SensorEnc(nombre_sensor: nombre, tipo: tipo, pines: array_pines, descripcion: descripcion, imagen: imagen, token: tkn)
        
        Api.shared.Add_Sensor(sensor: sensor,id_seccion: id_seccion ?? ""){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Registro", message: "Sensor registrado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                
                self.pin1.text="0"
                self.pin2.text="0"
                self.pin3.text="0"
                
            }
            
            else {
                let alert = UIAlertController(title: "Error", message: "verifique sus datos", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
        
    }


}
