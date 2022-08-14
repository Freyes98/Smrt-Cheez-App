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
    @IBOutlet weak var tipo_sensor: UITextField!
    @IBOutlet weak var pines: UITextField!
    @IBOutlet weak var descripcion_sensor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
