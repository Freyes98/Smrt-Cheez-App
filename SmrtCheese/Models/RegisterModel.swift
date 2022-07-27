//
//  RegisterModel.swift
//  SmrtCheese
//
//  Created by Francisco on 25/07/22.
//

import Foundation

struct RegisterModel: Encodable{
    
    let email: Int?
    let password: String?
    let fname: String?
    let lname: String?
    
}
