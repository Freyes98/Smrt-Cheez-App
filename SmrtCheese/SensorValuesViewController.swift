//
//  SensorValuesViewController.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import UIKit
import Alamofire
import Foundation
import PusherSwift

class SensorValuesViewController: UIViewController, PusherDelegate {

    var sensor: Sensor?
    var tkn: Token?
    var pusher : Pusher!
    
    @IBOutlet weak var sensor_img: UIImageView!
    @IBOutlet weak var name_sensor: UILabel!
    
    @IBOutlet weak var value_sensor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datos = UserDefaults.standard
        let token = datos.value(forKey: "token") as? String
            
        self.tkn = Token(type: nil, token: token)
        
        self.value_sensor.text = "Leyendo datos..."
        
        name_sensor.text = sensor?.nombreSensor
        
        if sensor?.tipo == "ultrasonico"{
            sensor_img.image = UIImage(named: "Ultrasonico.png")
        }
        
        else if sensor?.tipo == "temperatura"{
            sensor_img.image = UIImage(named: "Temperatura.png")
        }
        else if sensor?.tipo == "flama"{
            sensor_img.image = UIImage(named: "Flama.png")
        }
        else if sensor?.tipo == "humo"{
            sensor_img.image = UIImage(named: "humo.png")
        }
        else if sensor?.tipo == "infrarojo"{
            sensor_img.image = UIImage(named: "Infrarrojo.png")
        }
        
        
        
        
        let options = PusherClientOptions(
                host: .cluster("us3")
              )

              pusher = Pusher(
                key: "7e7ee4a9a85f45b68802",
                options: options
              )

              pusher.delegate = self

              // subscribe to channel
              let channel = pusher.subscribe("Smrtchess")

              // bind a callback to handle an event
            channel.bind(eventName: "my-event", eventCallback: { [self] (event: PusherEvent) in
                  if event.data != nil {
                    // you can parse the data as necessary
                      Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor: (self.sensor?.id)!){(result) in
                          switch result {
                          case .success(let json):
                              
                              if (json != nil){
                                  if self.sensor?.tipo == "ultrasonico"{
                                      self.value_sensor.text = "\(Int((json as! Value).value)) CM"
                                  }
                                  else if self.sensor?.tipo == "temperatura"{
                                      self.value_sensor.text = "\(Int((json as! Value).value)) °C"
                                  }
                                  else if self.sensor?.tipo == "humo" {
                                      
                                      if (Int((json as! Value).value)) == 1{
                                          self.value_sensor.text = "Humo detectado"
                                      }
                                      else{
                                          self.value_sensor.text = "Humo no detectado"
                                      }
                                  }
                                  else if self.sensor?.tipo == "infrarrojo" {
                                      
                                      if (Int((json as! Value).value)) == 1{
                                          self.value_sensor.text = "Movimiento detectado"
                                      }
                                      else{
                                          self.value_sensor.text = "Movimiento no detectados"
                                      }
                                  }
                                  else if self.sensor?.tipo == "flama" {
                                      
                                      if (Int((json as! Value).value)) == 1{
                                          self.value_sensor.textColor = .red
                                          self.value_sensor.text = "Fuego detectado"
                                      }
                                      else{
                                          self.value_sensor.textColor = .systemOrange
                                          self.value_sensor.text = "fuego no detectado"
                                      }
                                  }
                              }
                              else {
                                  self.value_sensor.text = "N/A"
                              }
                          case .failure(let err):
                              print(err.localizedDescription)
                      }
                      }
                      
                  }
              })

              pusher.connect()
        
        
        
        //Funcion para solicitar datos cada 3 segundos
        //Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(SensorValuesViewController.sayHello), userInfo: nil, repeats: true)

        
    
}
    
 

    

    @objc func sayHello()
    {

        Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor: (sensor?.id)!){(result) in
            switch result {
            case .success(let json):
                
                if (json != nil){
                    self.value_sensor.text = "\(Int((json as! Value).value))"
                }
                else {
                    self.value_sensor.text = "N/A"
                }
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
    }
    
    //paraenviar parametros
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "historial"{
            let value = segue.destination as! HistorialViewController
            value.id_sensor = sensor?.id
        
        }
    }
    
    
    @IBAction func Actualizar(_ sender: Any) {
        
        
        name_sensor.text = sensor?.nombreSensor
        // Do any additional setup after loading the view.
        Api.shared.Sensor_lastValue(tkn: self.tkn!, id_sensor:(sensor?.id)!){(result) in
            switch result {
            case .success(let json):

                if (json != nil){
                    self.value_sensor.text = "\(Int((json as! Value).value))"
                }
                else {
                    self.value_sensor.text = "N/A"
                }

    
            case .failure(let err):
                print(err.localizedDescription)
        }
        }
        
    }
}
