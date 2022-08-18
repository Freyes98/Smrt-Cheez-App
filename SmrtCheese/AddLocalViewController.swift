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
    //@IBOutlet weak var horario_apertura: UIDatePicker!
    @IBOutlet weak var apertura_picker: UIPickerView!
    var apertura: String?
    var cierre: String?
    
    @IBOutlet weak var Cierre_picker: UIPickerView!
    //@IBOutlet weak var horario_cierre: UIDatePicker!
    var recibir_id : String?
    var horarios = ["1:00 AM","2:00 AM","3:00 AM","4:00 AM","5:00 AM","6:00 AM","7:00 AM","8:00 AM","9:00 AM","10:00 AM","11:00 AM","12:00 AM","1:00 PM","2:00 PM","3:00 PM","4:00 PM","5:00 PM","6:00 PM","7:00 PM","8:00 PM","9:00 PM","10:00 PM","11:00 PM","12:00 PM"]
    //var horario : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //horario_apertura.Format = DateTimePickerFormat.Custom
        telefono_local.delegate = self

        apertura_picker.delegate = self
        apertura_picker.dataSource = self
        
        Cierre_picker.delegate = self
        Cierre_picker.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
 

      // Number of columns of data
     
    
    
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

   
            
            
            let horario = "De \(apertura ?? "") A \(cierre ?? "")"
            
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
    

}
extension AddLocalViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        horarios.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == apertura_picker {
            apertura = horarios[row]
            
         } else if pickerView == Cierre_picker{
             cierre = horarios[row]
         }
        
        return horarios[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
