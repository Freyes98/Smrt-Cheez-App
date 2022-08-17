//
//  Api.swift
//  SmrtCheese
//
//  Created by Francisco on 21/07/22.
//

import Foundation
import Alamofire
import UIKit

let url_base = "http://18.144.45.33:3333/api/v1/"


final class Api {
    
    static let shared = Api()

    //rutas
    
    var url_register = "\(url_base)users/register"
    var url_login = "\(url_base)users/login"
    var url_profile = "\(url_base)users/user"
    var url_queseria = "\(url_base)queseria/index"
    var url_Add_quseria = "\(url_base)queseria/create"
    var url_update_profile = "\(url_base)users/update"
    
    


    func Register_user(usuario: User, completionHandler: @escaping (Bool) ->()){
        
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_register,method:.post,parameters:usuario,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 201{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func Login_user(usuario: LoginUser, completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        
        
        AF.request(url_login,method:.post,parameters:usuario,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Response.self, from: data!)

                    
                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func Profile_user(tkn:Token, completionHandler: @escaping Handler){
        
        AF.request(url_profile,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(ResponseProfile.self, from: data!)

                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func Update_Profile(profile: ProfilEnc, completionHandler: @escaping (Bool) ->()){

        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_update_profile,method:.put,parameters:profile,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func update_Queseria(local: Local,id:String, completionHandler: @escaping (Bool) ->()){

        let url_Update_quseria = "\(url_base)queseria/update/\(id)"
        //queseria/update/62db2111bb3b833f987be7cd
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_Update_quseria,method:.patch,parameters:local,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func delete_Queseria(tkn:Token,id:String, completionHandler: @escaping Handler){
        
        let url_delete_queseria = "\(url_base)queseria/delete/\(id)"
        
        AF.request(url_delete_queseria,method:.delete,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(ResponseProfile.self, from: data!)

                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func Local_user(tkn:Token, completionHandler: @escaping Handler){
        
        AF.request(url_queseria,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Locales.self, from: data!)

                    if response.response?.statusCode == 200{
                        
                        
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func Add_Local(local: Local, completionHandler: @escaping (Bool) ->()){
        
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_Add_quseria,method:.post,parameters:local,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func Add_Seccion(Seccion: SeccionEnc,id_quseria:String, completionHandler: @escaping (Bool) ->()){
        
        let url_seccionadd = "\(url_base)apartados/\(id_quseria)/create"

        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_seccionadd,method:.post,parameters:Seccion,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    //Esta funcion no tranaka por que aun no existe la URL
    func update_Seccion(seccion: SeccionEnc,id:String, completionHandler: @escaping (Bool) ->()){
        let url_Update_seccion = "\(url_base)apartados/\(id)/update"
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_Update_seccion,method:.put,parameters:seccion,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func delete_Seccion(tkn:Token,id:String, completionHandler: @escaping Handler){
        
        let url_delete_seccion = "\(url_base)apartados/\(id)/destroy"
        
        AF.request(url_delete_seccion,method:.delete,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(ResponseProfile.self, from: data!)

                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func Seccion_user(tkn:Token,id_queseria:String, completionHandler: @escaping Handler){
    
        let url_apartados = "\(url_base)apartados/\(id_queseria)/get"

        AF.request(url_apartados,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Secciones.self, from: data!)

                    if response.response?.statusCode == 200{
                        
                        
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    func Sensor_user(tkn:Token,id_sensor:String, completionHandler: @escaping Handler){
        
        let url_sensores = "\(url_base)sensores/\(id_sensor)/get"

        AF.request(url_sensores,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Sensores.self, from: data!)

                    if response.response?.statusCode == 200{
                        
                        
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func update_Sensor(sensor: SensorEnc,id_sensor:String, completionHandler: @escaping (Bool) ->()){
        let url_Update_seccion = "\(url_base)sensores/\(id_sensor)/update"
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_Update_seccion,method:.put,parameters:sensor,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func delete_Sensor(tkn:Token,id:String, completionHandler: @escaping Handler){
        
        let url_delete_sensor = "\(url_base)sensores/\(id)/destroy"
        
        AF.request(url_delete_sensor,method:.delete,parameters: tkn).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(ResponseProfile.self, from: data!)

                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func Add_Sensor(sensor: SensorEnc,id_seccion:String, completionHandler: @escaping (Bool) ->()){
   
        let url_Add_Sensor = "\(url_base)sensores/\(id_seccion)/create"

        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url_Add_Sensor,method:.post,parameters:sensor,encoder:JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                   try JSONSerialization.jsonObject(with: data!,options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }catch {
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
    func Sensor_lastValue(tkn:Token,id_sensor:String, completionHandler: @escaping Handler){
        
        
        let url_values = "\(url_base)values/\(id_sensor)/get"

        AF.request(url_values,parameters: tkn).response{ response in
            //debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    
                    
                    let json = try JSONDecoder().decode(Values.self, from: data!).last

                    
                    if response.response?.statusCode == 200{
                        
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func Sensor_Values(tkn:Token,id_sensor:String, completionHandler: @escaping Handler){
        
        
        let url_values = "\(url_base)values/\(id_sensor)/get"

        AF.request(url_values,parameters: tkn).response{ response in
            //debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    
                    
                    let json = try JSONDecoder().decode(Values.self, from: data!)

                    
                    if response.response?.statusCode == 200{
                        
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "checa tu conexion a internet")))}
                    
                }catch {
                    completionHandler(.failure(.custom(message: "intenta de nuevo")))
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

