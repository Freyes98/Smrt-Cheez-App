//
//  LocalesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 25/07/22.
//

import UIKit

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
    
     
}
