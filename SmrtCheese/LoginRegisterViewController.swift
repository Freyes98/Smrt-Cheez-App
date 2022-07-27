//
//  ViewController.swift
//  SmrtCheese
//
//  Created by Fabian Ortiz on 09/07/22.
//

import UIKit
import Alamofire
import SwiftUI

class LoginRegisterViewController: UIViewController {
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    @IBOutlet weak var Mymaillogin: UITextField!
    @IBOutlet weak var Mynameregistrer: UITextField!
    @IBOutlet weak var Mypasswordlogin: UITextField!
    @IBOutlet weak var Mylastnameregistrer: UITextField!
    @IBOutlet weak var forgotpassword: UIButton!
    @IBOutlet weak var Mymailregistrer: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var mypasswordregistrer: UITextField!
    @IBOutlet weak var Myregistrerbutton: UIButton!
    @IBOutlet weak var ImageLogo: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textfields
        Mymaillogin.isHidden = false
        Mypasswordlogin.isHidden = false
        Mynameregistrer.isHidden = true
        Mylastnameregistrer.isHidden = true
        Mymailregistrer.isHidden = true
        mypasswordregistrer.isHidden = true
        Mymaillogin.layer.borderColor = UIColor.yellow.cgColor
        
        //buttons
        forgotpassword.isHidden = false
        Login.isHidden = false
        Myregistrerbutton.isHidden = true
        ImageLogo.isHidden = false
        
        
        //comprobacion de autentificacion
        
        let datos = UserDefaults.standard
        if let token = datos.value(forKey: "token") as? String{
            
            let homeTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
            
            self.present(homeTabBarController,animated: false,completion: nil)
            
        }
        
    }

    @IBAction func IniciarSesion(_ sender: Any) {
        
        guard let email = Mymaillogin.text, let password = Mypasswordlogin.text else {
            return
        }
     
        let usuario = LoginUser(email: email, password: password)
        
        Api.shared.Login_user(usuario: usuario){(result) in
            switch result {
            case .success(let json):
                let tkn = (json as! Response).token.token
                //let jsonResponse = (json as AnyObject).value(forKey: "token")
                //let token = (jsontoken as AnyObject).value(forKey: "token") as! String
                
                //Guardado de datos
                let datos = UserDefaults.standard
                datos.set(tkn, forKey: "token")
                datos.synchronize()
                
                //Borrar datos
                //esto ira en el logout
                
                //let datos = UserDefaults.standard
                //datos.removeObject(forKey: "token")
                //datos.synchronize()
                
                let homeTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
                
                self.present(homeTabBarController,animated: true,completion: nil)
                
                //let test = JSONResponse(token: jsonResponse)
                //print(test.token)
            case .failure(let err):
                let alert = UIAlertController(title: "Error", message: "Usuario no encontrado", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
    }
        
    
    
    @IBAction func Register(_ sender: Any) {
        
        guard let email = Mymailregistrer.text, let password = mypasswordregistrer.text, let firstname = Mynameregistrer.text, let lastname = Mylastnameregistrer.text else {
            return
        }
        let usuario = User(email: email, password: password,fname: firstname, lname: lastname)
        
        Api.shared.Register_user(usuario: usuario){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Registro", message: "Usuario registrado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)}
            else {
                let alert = UIAlertController(title: "Registro", message: "El usuario ya existe", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
        
    }
    
    @IBAction func mysementedaction(_ sender: Any) {
        if MySegmentedControl.selectedSegmentIndex == 1
        {
            Mymaillogin.isHidden = true
            Mypasswordlogin.isHidden = true
            Mynameregistrer.isHidden = false
            Mynameregistrer.isHidden = false
            Mymailregistrer.isHidden = false
            mypasswordregistrer.isHidden = false
            Mylastnameregistrer.isHidden = false
            forgotpassword.isHidden = true
            Login.isHidden = true
            Myregistrerbutton.isHidden = false
        }
        else{
            Mymaillogin.isHidden = false
            Mypasswordlogin.isHidden = false
            Mynameregistrer.isHidden = true
            Mynameregistrer.isHidden = true
            Mymailregistrer.isHidden = true
            Mylastnameregistrer.isHidden = true
            mypasswordregistrer.isHidden = true
            forgotpassword.isHidden = false
            Login.isHidden = false
            Myregistrerbutton.isHidden = true
        }
    }
    
}


