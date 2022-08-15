//
//  UpdateSensorViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class UpdateSensorViewController: UIViewController, UITextFieldDelegate{

    var sensor : Sensor?
    
    @IBOutlet weak var name_sensor: UITextField!
    
    @IBOutlet weak var Menu: UIButton!
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var Menutipo: UIButton!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var descripcion_sensor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pin1.isHidden = true
        self.pin2.isHidden = true
        self.pin3.isHidden = true
        
        pin1.delegate = self
        pin2.delegate = self
        pin3.delegate = self
        
        
        Menu.addAction(UIAction(handler: {(_)in print("action")}), for: .touchUpInside)
        Menu.menu = addMenuItems()
        
        Menutipo.addAction(UIAction(handler: {(_)in print("action")}), for: .touchUpInside)
        Menutipo.menu = addMenuItemsTsensor()
        
        pin1.text="0"
        pin2.text="0"
        pin3.text="0"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateAction(_ sender: Any) {
        
        
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
    
}
