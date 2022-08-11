//
//  SensoresViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit

class SensoresViewController: UIViewController {

    var sensors : [Sensor] = []
    var recibir_id : String?
    var enviar_id : String?
    var sensor: Sensor?
    
    lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SensoresViewController.actualizarDatos(_:)), for: .valueChanged)
        //color de rueda
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    @objc func actualizarDatos(_ refreshControl: UIRefreshControl){
        
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Sensor_user(tkn: tkn,id_sensor: recibir_id ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                let countt = (json as! Sensores).count
                sensors = json as! [Sensor]
                print(countt)
            case .failure(let err):
                print(err.localizedDescription)
 }
            self.TablaSensores.register(UINib(nibName: "SensorCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSensor")
            
            self.TablaSensores.delegate = self
            self.TablaSensores.dataSource = self
        

        }
            self.TablaSensores.reloadData()
            refreshControl.endRefreshing()

        }
    
    
    @IBOutlet weak var labelselecion: UILabel!
    //var enviar_id : String?
    
    @IBOutlet weak var TablaSensores: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Sensor_user(tkn: tkn,id_sensor: recibir_id ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                let countt = (json as! Sensores).count
                sensors = json as! [Sensor]
                print(countt)
            case .failure(let err):
                print(err.localizedDescription)
        }
            self.TablaSensores.register(UINib(nibName: "SensorCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSensor")

            self.TablaSensores.delegate = self
            self.TablaSensores.dataSource = self
        }
        
        
        
        labelselecion.text = recibir_id
        self.TablaSensores.addSubview(refreshControl)
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.TablaSensores.reloadData()
    }
    //paraenviar parametros
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar_id"{
            let destino = segue.destination as! AddSensorViewController
            destino.id_seccion = recibir_id
        }
        if segue.identifier == "enviar_update"{
            let update_sensor = segue.destination as! UpdateSensorViewController
            update_sensor.sensor = sensor
        }
        //este sera para enviar id del sensor seleccionado a la pantalla sensor
        
        //if segue.identifier == "enviar_id_sensor"{
        //    let sensor = segue.destination as! SensoresViewController
        //    sensor.recibir_id = enviar_id
        
        //}
    }
    
  

}
extension SensoresViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaSensores.dequeueReusableCell(withIdentifier: "celdaSensor", for: indexPath) as! SensorCeldaTableViewCell
        celda.name_sensor.text = sensors[indexPath.row].nombreSensor
        celda.tipo_sensor.text = sensors[indexPath.row].tipo
        
        return celda
    }
    
    //MENU SLIDE (EDIT AND DELTE)
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //BOTON EDIT
      let editItem = UIContextualAction(style: .destructive, title: "Editar") {  (contextualAction, view, boolValue) in
          //Code I want to do here
          
          self.sensor = self.sensors[indexPath.row]
          self.performSegue(withIdentifier: "enviar_update", sender: self)
          
      }
        //BOTON DELETE
      let deleteItem = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in
            //Code I want to do here
          self.deleteAction(sensor: self.sensors[indexPath.row], indexpath: indexPath)
      }
        
        editItem.backgroundColor = .black
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem,editItem])

      return swipeActions
  }
    //ENVIAR PARAMETRO SELECCIONADO
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.enviar_id = sensors[indexPath.row].id
        //self.performSegue(withIdentifier: "enviar_id", sender: self)
    }
    
    private func updateAction(sensor:Sensor,indexpath: IndexPath){
        
        
        
    }
    
    private func deleteAction(sensor:Sensor,indexpath: IndexPath){

        let alert = UIAlertController(title: "Delete", message: "Estas seguro que deseas eliminar?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "yes", style: .default){(action) in
            
            let datos = UserDefaults.standard
            let token = datos.value(forKey: "token") as? String
                
            let tkn = Token(type: nil, token: token)
            Api.shared.delete_Sensor(tkn: tkn,id: self.sensors[indexpath.row].id ?? "" ){ [self](result) in
                switch result {
            //
                case .success(let json):
                    let countt = (json as! Sensores).count
                    sensors = json as! [Sensor]
                    print(countt)
            //
                case .failure(let err):
                    print(err.localizedDescription)
            //
                    self.TablaSensores.register(UINib(nibName: "SeccionCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaSeccion")
            
                    self.TablaSensores.delegate = self
                    self.TablaSensores.dataSource = self
            //
            }
                self.TablaSensores.reloadData()
                refreshControl.endRefreshing()

            }
            
            self.sensors.remove(at: indexpath.row)
            self.TablaSensores?.deleteRows(at: [indexpath], with: .automatic)
            
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
    
    }
    
    
    
  
    
}
    
