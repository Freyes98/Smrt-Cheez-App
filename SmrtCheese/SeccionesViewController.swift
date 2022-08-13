//
//  SeccionesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 02/08/22.
//

import UIKit

class SeccionesViewController: UIViewController {
    
    @IBOutlet weak var TablaSecciones: UITableView!
    
    var Apartados : [Seccion] = []
    var recibir_id : String?
    var enviar_id : String?
    var seccion: Seccion?
    
    lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SeccionesViewController.actualizarDatos(_:)), for: .valueChanged)
        //color de rueda
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    @objc func actualizarDatos(_ refreshControl: UIRefreshControl){
        
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Seccion_user(tkn: tkn,id_queseria:recibir_id ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                let countt = (json as! Secciones).count
                Apartados = json as! [Seccion]
                print(countt)
            case .failure(let err):
                print(err.localizedDescription)
 }
        
            self.TablaSecciones.register(UINib(nibName: "SeccionCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSeccion")
    
            self.TablaSecciones.delegate = self
            self.TablaSecciones.dataSource = self
        

        }
            self.TablaSecciones.reloadData()
            refreshControl.endRefreshing()

        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)

        Api.shared.Seccion_user(tkn: tkn,id_queseria:recibir_id ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                let countt = (json as! Secciones).count
                Apartados = json as! [Seccion]
                print(countt)
            case .failure(let err):
                print(err.localizedDescription)
 }
        
            self.TablaSecciones.register(UINib(nibName: "SeccionCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSeccion")
    
            self.TablaSecciones.delegate = self
            self.TablaSecciones.dataSource = self
            
            self.TablaSecciones.addSubview(refreshControl)
        

        }
        // Do any additional setup after loading the view.
    }
  
    
    //FUNCION PARA ENVIAR ID DEL LOCAL A LA SECCION
    @IBAction func Addlocal(_ sender: Any) {
        performSegue(withIdentifier: "enviar_id", sender: self)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.TablaSecciones.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar_id"{
            let destino = segue.destination as! AddSeccionViewController
            destino.recibir_id_queseria = recibir_id
        }
        if segue.identifier == "enviar_update"{
            let update_seccion = segue.destination as! UpdateSeccionViewController
            update_seccion.seccion = seccion
        }
        if segue.identifier == "enviar_id_sensor"{
            let sensor = segue.destination as! SensoresViewController
            sensor.recibir_id = enviar_id
            sensor.seccion = seccion
            
        }
    }
}




extension SeccionesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Apartados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaSecciones.dequeueReusableCell(withIdentifier: "celdaSeccion", for: indexPath) as! SeccionCeldaTableViewCell
        celda.myApartadoname.text = Apartados[indexPath.row].nombreApartado
        celda.myDescription.text = Apartados[indexPath.row].descripcion
        //celda.myApartadoname.text = "Juann"
        //celda.myDescription.text = "juan"
        
        return celda
    }
    
    //MENU SLIDE (EDIT AND DELTE)
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //BOTON EDIT
      let editItem = UIContextualAction(style: .destructive, title: "Editar") {  (contextualAction, view, boolValue) in
          //Code I want to do here
          
          self.seccion = self.Apartados[indexPath.row]
          self.performSegue(withIdentifier: "enviar_update", sender: self)
          
      }
        //BOTON DELETE
      let deleteItem = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in
            //Code I want to do here
          self.deleteAction(seccion: self.Apartados[indexPath.row], indexpath: indexPath)
      }
        
        editItem.backgroundColor = .black
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem,editItem])

      return swipeActions
  }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.enviar_id = Apartados[indexPath.row].id
        self.seccion = Apartados[indexPath.row]
        self.performSegue(withIdentifier: "enviar_id_sensor", sender: self)
    }
    
    
    
    
    
    
    
    private func updateAction(seccion:Seccion,indexpath: IndexPath){
        
        
        
    }
    private func deleteAction(seccion:Seccion,indexpath: IndexPath){

        let alert = UIAlertController(title: "Delete", message: "Estas seguro que deseas eliminar?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "yes", style: .default){(action) in
            
            let datos = UserDefaults.standard
            let token = datos.value(forKey: "token") as? String
                
            let tkn = Token(type: nil, token: token)
            Api.shared.delete_Seccion(tkn: tkn,id:self.Apartados[indexpath.row].id ){ [self](result) in
                switch result {
            //
                case .success(let json):
                    //let countt = (json as! Secciones).count
                    Apartados = json as! [Seccion]
                    //print(countt)
            //
                case .failure(let err):
                    print(err.localizedDescription)
            //
                    self.TablaSecciones.register(UINib(nibName: "SeccionCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSeccion")
            
                    self.TablaSecciones.delegate = self
                    self.TablaSecciones.dataSource = self
            //
            }
                self.TablaSecciones.reloadData()
                refreshControl.endRefreshing()

            }
            
            self.Apartados.remove(at: indexpath.row)
            self.TablaSecciones?.deleteRows(at: [indexpath], with: .automatic)
            
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
    
    }
    
}

