//
//  ProfileUser.swift
//  SmrtCheese
//
//  Created by Francisco on 26/07/22.
//

import Foundation

struct ResponseProfile: Codable {
    let id: String
    let email: String
    let password: String
    let fname: String
    let lname: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email = "email"
        case password = "password"
        case fname = "fname"
        case lname = "lname"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//struct token2: Encodable {
    
//  let token: String
//}
