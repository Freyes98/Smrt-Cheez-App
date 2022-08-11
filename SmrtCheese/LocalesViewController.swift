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
    var enviar_id : String?
    var local: Queseria?
    
    lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LocalesViewController.actualizarDatos(_:)), for: .valueChanged)
        //color de rueda
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    @objc func actualizarDatos(_ refreshControl: UIRefreshControl){
        
        
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
                
                self.TablaLocales.register(UINib(nibName: "LocalCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaLocal")
        
                self.TablaLocales.delegate = self
                self.TablaLocales.dataSource = self
                
        }
            self.TablaLocales.reloadData()
            refreshControl.endRefreshing()

        }
    }
    
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
        
        
        
        
        self.TablaLocales.addSubview(refreshControl)
        
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
    //Metodos para enviar id y navegar a otra pantalla
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         enviar_id = Locales[indexPath.row].id
        performSegue(withIdentifier: "enviar_id", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let editItem = UIContextualAction(style: .destructive, title: "Editar") {  (contextualAction, view, boolValue) in
          //Code I want to do here
          self.local = self.Locales[indexPath.row]
          self.performSegue(withIdentifier: "enviar_edit", sender: self)
          
      }
        
      let deleteItem = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in
            //Code I want to do here
          self.deleteAction(seccion: self.Locales[indexPath.row], indexpath: indexPath)
      }
        editItem.backgroundColor = .black
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem,editItem])

      return swipeActions
  }
    

    private func deleteAction(seccion:Queseria,indexpath: IndexPath){
        
        let alert = UIAlertController(title: "Delete", message: "Estas seguro que deseas eliminar?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "yes", style: .default){(action) in
            
            let datos = UserDefaults.standard
            let token = datos.value(forKey: "token") as? String
                
            let tkn = Token(type: nil, token: token)
            Api.shared.delete_Queseria(tkn: tkn,id:self.Locales[indexpath.row].id ?? ""){ [self](result) in
                switch result {
            //
                case .success(let json):
                    let countt = (json as! Locales).count
                    Locales = json as! [Queseria]
                    print(countt)
            //
                case .failure(let err):
                    print(err.localizedDescription)
            //
                    self.TablaLocales.register(UINib(nibName: "LocalCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaLocal")
            
                    self.TablaLocales.delegate = self
                    self.TablaLocales.dataSource = self
            //
            }
                self.TablaLocales.reloadData()
                refreshControl.endRefreshing()

            }
            
            self.Locales.remove(at: indexpath.row)
            self.TablaLocales?.deleteRows(at: [indexpath], with: .automatic)
            
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar_id" {
            let secciones = segue.destination as! SeccionesViewController
            secciones.recibir_id = enviar_id
        }
        if segue.identifier == "enviar_edit"{
            
            let update_local = segue.destination as! UpdateLocalViewController
            update_local.local = local
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.TablaLocales.reloadData()
        
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
