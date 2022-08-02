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
        

        }
        // Do any additional setup after loading the view.
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
    
    
    
}

