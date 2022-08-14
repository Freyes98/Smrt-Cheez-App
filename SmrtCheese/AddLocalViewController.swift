//
//  AddLocalViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 09/08/22.
//

import UIKit

class AddLocalViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var descripcion_local: UITextField!
    
    @IBOutlet weak var direccion_local: UITextField!
    @IBOutlet weak var telefono_local: UITextField!
    @IBOutlet weak var name_local: UITextField!
    @IBOutlet weak var Btn_Añadir: UIButton!
    @IBOutlet weak var horario_apertura: UIDatePicker!
    
    @IBOutlet weak var horario_cierre: UIDatePicker!
    var recibir_id : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //horario_apertura.Format = DateTimePickerFormat.Custom
        telefono_local.delegate = self
   
     

        // Do any additional setup after loading the view.
    }
    //funcion para ingresar solo numeros
    func textField(_ _textField:UITextField,shouldChangeCharactersIn range: NSRange,replacementString string:
        String)-> Bool{
        
        let caracteres = CharacterSet.decimalDigits
        let caracterSet = CharacterSet(charactersIn:string)
        return caracteres.isSuperset(of:caracterSet)
        }
    
    @IBAction func Add_action(_ sender: Any) {
        
        let datos = UserDefaults.standard
        let tkn = datos.value(forKey: "token") as? String
        
        guard let nombre = name_local.text, let descripcion = descripcion_local.text, let telefono = telefono_local.text,let direccion = direccion_local.text else {
            return
        }
        //VALIDACIONES
    
        
        if telefono.count < 7{
                 let alert = UIAlertController(title: "Invalid num", message: "Ingrese un numero de teledono valido", preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
                 self.present(alert, animated: true, completion: nil)
            telefono_local.text = ""
                
                    
        }
        else if nombre.count < 4{
            let alert = UIAlertController(title: "Invalid name", message: "ingrese un nombre de local real", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            name_local.text = ""
        }
        else if descripcion.count < 4 {
            let alert = UIAlertController(title: "Invalid num", message: "Ingrese una descripcion mas larga", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
            self.present(alert, animated: true, completion: nil)
            descripcion_local.text = ""
        }
        
        else if direccion.count < 4 {
            let alert = UIAlertController(title: "Invalid address", message: "Ingrese una horario valido", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            direccion_local.text = ""
        }
        else {
            
            //let apertura = Calendar.current.dateComponents([.hour, .minute], from: horario_apertura.date)
            //let cierre = Calendar.current.dateComponents([.hour, .minute], from: horario_apertura.date)

   
            
            
            let horario = "De \(horario_apertura.date) A \(horario_cierre.date)"
            
            let local = Local(nombre_queseria: nombre, telefono: telefono, direccion: direccion, horarios: horario, descripcion: descripcion,token: tkn)
            
            Api.shared.Add_Local(local: local){(isSucess) in
                if isSucess {
                let alert = UIAlertController(title: "Registro", message: "Local registrado correctamente", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    
                    self.name_local.text = ""
                    self.descripcion_local.text = ""
                    self.telefono_local.text = ""
                    self.direccion_local.text = ""
                    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
