//
//  HistorialViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 17/08/22.
//

import UIKit

class HistorialViewController: UIViewController {
    var id_sensor : String?
    var values : [Value] = []
    
    
    @IBOutlet weak var TableHistorial: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Sensor_Values(tkn: tkn,id_sensor: id_sensor ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                //let countt = (json as! Values).count
                values = json as! [Value]
                
            case .failure(let err):
                print(err.localizedDescription)
        }
            self.TableHistorial.register(UINib(nibName: "HistorialCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaHistorial")

            self.TableHistorial.delegate = self
            self.TableHistorial.dataSource = self
        }
    }
    

    @IBAction func Buscar(_ sender: Any) {
        
        
        // Do any additional setup after loading the view.
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        let tkn = Token(type: nil, token: token)
        
        Api.shared.Sensor_Values(tkn: tkn,id_sensor: id_sensor ?? ""){ [self](result) in
            switch result {
            case .success(let json):
                //let countt = (json as! Values).count
                values = json as! [Value]
                
            case .failure(let err):
                print(err.localizedDescription)
        }
            self.TableHistorial.register(UINib(nibName: "HistorialCeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaHistorial")

            self.TableHistorial.delegate = self
            self.TableHistorial.dataSource = self
        }
    }
}

extension HistorialViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TableHistorial.dequeueReusableCell(withIdentifier: "celdaHistorial", for: indexPath) as! HistorialCeldaTableViewCell
        celda.Fecha.text = values[indexPath.row].createdAt
        celda.Valor.text = String(values[indexPath.row].value)
        return celda
    }
}
