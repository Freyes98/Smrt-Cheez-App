//
//  LocalesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 25/07/22.
//

import UIKit
import Network
class LocalesViewController: UIViewController {
    @IBOutlet weak var TablaLocales: UITableView!
        
    var Locales : [Queseria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Local_user(tkn: tkn){ [self](result) in
            switch result {
            case .success(let json):
                let countt = (json as! Locales).count
                Locales = json as! [Queseria]
                print(countt)
            case .failure(let err):
                print(err.localizedDescription)
        }
        
            self.TablaLocales.register(UINib(nibName: "LocalCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaLocal")
    
            self.TablaLocales.delegate = self
            self.TablaLocales.dataSource = self
        

        }
    }
    
}


extension LocalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Locales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaLocales.dequeueReusableCell(withIdentifier: "celdaLocal", for: indexPath) as! LocalCeldaTableViewCell
        celda.MyLocalname.text = Locales[indexPath.row].nombreQueseria
        celda.MylocalAdress.text = Locales[indexPath.row].direccion
        
        
        return celda
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
}
