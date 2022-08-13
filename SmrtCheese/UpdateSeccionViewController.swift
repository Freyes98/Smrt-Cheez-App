//
//  UpdateSeccionViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class UpdateSeccionViewController: UIViewController {

    @IBOutlet weak var nombre_seccion: UITextField!
    @IBOutlet weak var descripcion_seccion: UITextField!
    
    var seccion: Seccion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombre_seccion.text = seccion?.nombreApartado
        descripcion_seccion.text = seccion?.descripcion
        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateAction(_ sender: Any) {
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
        
        
        let seccion_update = SeccionEnc(nombre_apartado: nombre_seccion.text, descripcion: descripcion_seccion.text, token: token)
        
        Api.shared.update_Seccion(seccion:seccion_update,id: seccion?.id ?? "" ){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Update", message: "Seccion actualizado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                
            }
            
            else {
                let alert = UIAlertController(title: "Error", message: "Ocurrio un error al actualizar", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
    }

}
