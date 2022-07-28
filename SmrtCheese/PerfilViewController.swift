//
//  PerfilViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 25/07/22.
//

import UIKit
import Alamofire

class PerfilViewController: UIViewController {

    @IBOutlet weak var myemail: UILabel!
    @IBOutlet weak var mylastname: UILabel!
    @IBOutlet weak var myname: UILabel!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
           

        
        Api.shared.Profile_user(tkn: tkn){(result) in
            switch result {
            case .success(let json):
                let tkn = (json as! ResponseProfile).email
                //let jsonResponse = (json as AnyObject).value(forKey: "token")
                //let token = (jsontoken as AnyObject).value(forKey: "token") as! String
                self.myemail.text = (json as! ResponseProfile).email
                self.myname.text = (json as! ResponseProfile).fname
                self.mylastname.text = (json as! ResponseProfile).lname
                //Guardado de datos
                print(tkn)
                
                //Borrar datos
                //esto ira en el logout
                
                //let datos = UserDefaults.standard
                //datos.removeObject(forKey: "token")
                //datos.synchronize()
                
    
                
                //let test = JSONResponse(token: jsonResponse)
                //print(test.token)
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
        
        
        
        // Do any additional setup after loading the view.
    }

}
