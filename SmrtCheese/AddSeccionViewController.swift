//
//  AddSeccionViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 09/08/22.
//

import UIKit

class AddSeccionViewController: UIViewController {

    @IBOutlet weak var nombre_seccion: UITextField!
    @IBOutlet weak var descripcion_seccion: UITextField!
    var recibir_id_queseria: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
   
    @IBAction func AddSection(_ sender: Any) {
        
        let datos = UserDefaults.standard
        let tkn = datos.value(forKey: "token") as? String
        
        guard let nombre = nombre_seccion.text, let descripcion = descripcion_seccion.text else {
            return
        }
        let seccion = SeccionEnc(nombre_apartado: nombre, descripcion: descripcion, token: tkn)
        
        Api.shared.Add_Seccion(Seccion: seccion,id_quseria: recibir_id_queseria ?? ""){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Registro", message: "Seccion registrado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                
            }
            
            else {
                let alert = UIAlertController(title: "Error", message: "verifique sus datos", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
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
