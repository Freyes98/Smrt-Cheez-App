//
//  UpdateLocalViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class UpdateLocalViewController: UIViewController, UITextFieldDelegate {

    var local: Queseria?
    
    @IBOutlet weak var name_local: UITextField!
    @IBOutlet weak var ScrollViewController: UIScrollView!
    @IBOutlet weak var telefono_local: UITextField!
    @IBOutlet weak var address_local: UITextField!
    @IBOutlet weak var horario_local: UITextField!
    @IBOutlet weak var descripcion_local: UITextField!
    
    override func viewDidLoad() {
        telefono_local.delegate = self
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        name_local.text = local?.nombreQueseria
        telefono_local.text = local?.telefono
        address_local.text = local?.direccion
        horario_local.text = local?.horarios
        descripcion_local.text = local?.descripcion

        // Do any additional setup after loading the view.
    }
    var isExpand : Bool = false
    @objc func keyboardApear() {
        if !isExpand{
            self.ScrollViewController.contentSize = CGSize(width: self.view.frame.width, height: self.ScrollViewController.frame.height + 250)
            isExpand = true
        }
    }
    @objc func keyboardDisapear(){
        if isExpand{
            self.ScrollViewController.contentSize = CGSize(width: self.view.frame.width, height: self.ScrollViewController.frame.height - 250)
            self.isExpand = false
        }

    }
    //funcion para ingresar solo numeros
    func textField(_ _textField:UITextField,shouldChangeCharactersIn range: NSRange,replacementString string:
        String)-> Bool{
        
        let caracteres = CharacterSet.decimalDigits
        let caracterSet = CharacterSet(charactersIn:string)
        return caracteres.isSuperset(of:caracterSet)
        }
    
    

    @IBAction func updateAction(_ sender: Any) {
        
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
        
        
        //guard let name = myname.text, let lastname = mylastname.text, let email = myemail.text
        //else {
        //    return
        //}
        let local_update = Local(nombre_queseria: name_local.text, telefono: telefono_local.text, direccion: address_local.text, horarios: horario_local.text, descripcion: descripcion_local.text, token: token)
        
        Api.shared.update_Queseria(local:local_update,id: local?.id ?? "" ){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Update", message: "Local actualizado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                
            }
            
            else {
                let alert = UIAlertController(title: "Error", message: "Error al actualizar", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
        
    }

}
