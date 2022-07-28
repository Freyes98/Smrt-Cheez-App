//
//  Api.swift
//  SmrtCheese
//
//  Created by Francisco on 21/07/22.
//

import Foundation
import Alamofire
import UIKit

final class Api {
 
    static let shared = Api()

    //rutas
    let url_register = "http://127.0.0.1:3333/api/v1/users/register"
    let url_login = "http://127.0.0.1:3333/api/v1/users/login"
    let url_profile = "http://127.0.0.1:3333/api/v1/users/user"
    let url_queseria = "http://127.0.0.1:3333/api/v1/queseria/index"
    


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
}

