//
//  UpdateSensorViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class UpdateSensorViewController: UIViewController, UITextFieldDelegate{

    var sensor : Sensor?
    var array_pines: [Int] = []
    var id_sensor : String?
    var tipo_sensor: String?
    
    @IBOutlet weak var name_sensor: UITextField!
    @IBOutlet weak var Menu: UIButton!
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var Menutipo: UIButton!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var descripcion_sensor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pin1.delegate = self
        pin2.delegate = self
        pin3.delegate = self
        
        
        name_sensor.text = sensor?.nombreSensor
        Menutipo.setTitle(sensor?.tipo, for: .normal)
        descripcion_sensor.text = sensor?.descripcion
        
        if sensor?.pines!.count ?? 0 == 1 {
            
            pin1.text = String(sensor?.pines![0] ?? 0)
            self.pin1.isHidden = false
            self.pin2.isHidden = true
            self.pin3.isHidden = true
            
            self.pin2.text = "0"
            self.pin3.text = "0"
        }
        else if sensor?.pines!.count ?? 0 == 2 {
            
            pin1.text = String(sensor?.pines![0] ?? 0)
            pin2.text = String(sensor?.pines![1] ?? 0)
    
            self.pin1.isHidden = false
            self.pin2.isHidden = false
            self.pin3.isHidden = true
            
            
            self.pin3.text = "0"
        }
        else if sensor?.pines!.count ?? 0 == 3 {
            
            pin1.text = String(sensor?.pines![0] ?? 0)
            pin2.text = String(sensor?.pines![1] ?? 0)
            pin3.text = String(sensor?.pines![2] ?? 0)
            
            self.pin1.isHidden = false
            self.pin2.isHidden = false
            self.pin3.isHidden = false
        
        }
        
        
        
        
        
        
        Menu.addAction(UIAction(handler: {(_)in print("action")}), for: .touchUpInside)
        Menu.menu = addMenuItems()
        
        Menutipo.addAction(UIAction(handler: {(_)in print("action")}), for: .touchUpInside)
        Menutipo.menu = addMenuItemsTsensor()
        
        
    }
    

    @IBAction func updateAction(_ sender: Any) {
        
        let datos = UserDefaults.standard
        let tkn = datos.value(forKey: "token") as? String
        
        guard let nombre = name_sensor.text,
              let descripcion = descripcion_sensor.text,
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
        
        let sensor = SensorEnc(nombre_sensor: nombre, tipo: tipo_sensor, pines: array_pines, descripcion: descripcion, imagen: "Sin link", token: tkn)
        
        Api.shared.update_Sensor(sensor: sensor,id_sensor:id_sensor ?? ""){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Update", message: "Sensor actualizado correctamente", preferredStyle: UIAlertController.Style.alert)

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
    
    //funcion para ingresar solo numeros
    func textField(_ _textField:UITextField,shouldChangeCharactersIn range: NSRange,replacementString string:
        String)-> Bool{
        
        let caracteres = CharacterSet.decimalDigits
        let caracterSet = CharacterSet(charactersIn:string)
        return caracteres.isSuperset(of:caracterSet)
        }
    
    func addMenuItems() -> UIMenu {
        let menuitems = UIMenu(title: "", children: [
            
            UIAction(title:"1", handler: {(_)in print("1")
                self.pin1.isHidden = false
                self.pin2.isHidden = true
                self.pin3.isHidden = true
                
            }),
            UIAction(title:"2", handler: {(_)in print("2")
                self.pin1.isHidden = false
                self.pin2.isHidden = false
                self.pin3.isHidden = true
                
            }),
            UIAction(title:"3", handler: {(_)in print("3")
                self.pin1.isHidden = false
                self.pin2.isHidden = false
                self.pin3.isHidden = false
            })
        
        
        ])
        return menuitems
    }
    
    func addMenuItemsTsensor() -> UIMenu {
        let menuitems = UIMenu(title: "", children: [
            
            UIAction(title:"Ultrasonico", handler: {(_)in
                
                self.tipo_sensor = "ultrasonico"
                self.Menutipo.setTitle("Ultrasonico", for: .normal)
                
            }),
            UIAction(title:"Humo", handler: {(_)in
                
                self.tipo_sensor = "humo"
                self.Menutipo.setTitle("Humo", for: .normal)
                
            }),
            UIAction(title:"Flama", handler: {(_)in
                
                self.tipo_sensor = "flama"
                self.Menutipo.setTitle("Flama", for: .normal)
            }),
            
            UIAction(title:"Temperatura", handler: {(_)in
                
                self.tipo_sensor = "temperatura"
                self.Menutipo.setTitle("Temperatura", for: .normal)
            }),
            
            UIAction(title:"Infrarojo", handler: {(_)in
                
                self.tipo_sensor = "infrarojo"
                self.Menutipo.setTitle("Infrarojo", for: .normal)
            })
        
        
        ])
        return menuitems
    }
    
}
