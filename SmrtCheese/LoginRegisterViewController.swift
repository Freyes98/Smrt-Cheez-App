//
//  ViewController.swift
//  SmrtCheese
//
//  Created by Fabian Ortiz on 09/07/22.
//

import UIKit
import Alamofire
import SwiftUI
import Network

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
        if datos.value(forKey: "token") is String{
            
            //let homeTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
            
            //self.present(homeTabBarController,animated: false,completion: nil)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let monitor = NWPathMonitor()
               monitor.pathUpdateHandler = { path in
                   if path.status != .satisfied {
                       // Not connected
                       DispatchQueue.main.async{
                           let alert = UIAlertController(title: "Error", message: "Comprueba tu conexion a internet", preferredStyle: UIAlertController.Style.alert)

                                   // add an action (button)
                                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                   // show the alert
                           self.present(alert, animated: true, completion: nil)
                       }
                      
                   }
                   else if path.usesInterfaceType(.cellular) {
                       print("celular")
                       // Cellular 3/4/5g connection
                   }
                   else if path.usesInterfaceType(.wifi) {
                       print("wifi")
                       // Wi-Fi connection
                   }
                   else if path.usesInterfaceType(.wiredEthernet) {
                       // Ethernet connection
                       print("ethernet")
                   }
               }

               monitor.start(queue: DispatchQueue.global(qos: .background))
    }
        
    
    
    
    
    
    
    
    
    
    
    
    
    //Buttom actions
    

    @IBAction func IniciarSesion(_ sender: Any) {
        
        guard let email = Mymaillogin.text, let password = Mypasswordlogin.text else {
            return
        }
     
        let usuario = LoginUser(email: email, password: password)
        
        Api.shared.Login_user(usuario: usuario){(result) in
            switch result {
            case .success(let json):
                let tkn = (json as! Response).token.token
                
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

            case .failure(_):
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
                    self.present(alert, animated: true, completion: nil)
                self.MySegmentedControl.selectedSegmentIndex = 0
                if self.MySegmentedControl.selectedSegmentIndex == 0
                {
                    self.Mymaillogin.isHidden = false
                    self.Mypasswordlogin.isHidden = false
                    self.Mynameregistrer.isHidden = true
                    self.Mynameregistrer.isHidden = true
                    self.Mymailregistrer.isHidden = true
                    self.Mylastnameregistrer.isHidden = true
                    self.mypasswordregistrer.isHidden = true
                    self.forgotpassword.isHidden = false
                    self.Login.isHidden = false
                    self.Myregistrerbutton.isHidden = true
                }
                else{
                   
                    
                    self.Mymaillogin.isHidden = true
                    self.Mypasswordlogin.isHidden = true
                    self.Mynameregistrer.isHidden = false
                    self.Mynameregistrer.isHidden = false
                    self.Mymailregistrer.isHidden = false
                    self.mypasswordregistrer.isHidden = false
                    self.Mylastnameregistrer.isHidden = false
                    self.forgotpassword.isHidden = true
                    self.Login.isHidden = true
                    self.Myregistrerbutton.isHidden = false
                }
            }
            
            else {
                let alert = UIAlertController(title: "Registro", message: "El usuario ya existe", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)}
        }
        Mymailregistrer.text=""
        mypasswordregistrer.text=""
        Mynameregistrer.text=""
        Mylastnameregistrer.text=""
        
        
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



