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
    @IBOutlet weak var scrollviewController: UIScrollView!
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
        
    
    var isExpand : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Mymaillogin.delegate = self
        Mypasswordlogin.delegate = self
        
        Mymaillogin.text = ""
        Mypasswordlogin.text = ""
        
        Mynameregistrer.delegate = self
        Mylastnameregistrer.delegate = self
        Mymailregistrer.delegate = self
        mypasswordregistrer.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    @objc func keyboardApear() {
        if !isExpand{
            self.scrollviewController.contentSize = CGSize(width: self.view.frame.width, height: self.scrollviewController.frame.height + 300)
            isExpand = true
        }
    }
    @objc func keyboardDisapear(){
        if isExpand{
            self.scrollviewController.contentSize = CGSize(width: self.view.frame.width, height: self.scrollviewController.frame.height - 300)
            self.isExpand = false
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
        
        self.login()
    }
    
    
    @IBAction func Register(_ sender: Any) {
        
        self.registro()
        
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

extension LoginRegisterViewController: UITextFieldDelegate{
    
    func registro(){
        
        let email = Mynameregistrer.text
        let firstname = Mylastnameregistrer.text
        let lastname = Mymailregistrer.text
        let password = mypasswordregistrer.text
        
        
        let usuario = User(email: email, password: password,fname: firstname, lname: lastname)
        
        Api.shared.Register_user(usuario: usuario){(isSucess) in
            if isSucess {
            let alert = UIAlertController(title: "Registro", message: "Usuario registrado correctamente", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
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
    func login(){
        let email = Mymaillogin.text
        let password = Mypasswordlogin.text
     
        let usuario = LoginUser(email: email, password: password)
        
        Api.shared.Login_user(usuario: usuario){(result) in
            switch result {
            case .success(let json):
                let tkn = (json as! Response).token.token
                
                //Guardado de datos
                let datos = UserDefaults.standard
                datos.set(tkn, forKey: "token")
                datos.synchronize()
                
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
        
        if textField == Mymaillogin{
            Mypasswordlogin.becomeFirstResponder()
        }
        if textField == Mypasswordlogin{
            login()
        
    }
        return true
}
}


