//
//  LoginUser.swift
//  SmrtCheese
//
//  Created by Francisco on 25/07/22.
//

import Foundation
enum APIErrors: Error{
    case custom(message: String)
}
typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void

struct LoginUser: Encodable {
    
    let email: String?
    let password: String?
}


// MARK: - Welcome
struct Response: Codable {
    let status: String
    let message: String
    let token: Token

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case token = "token"
    }
}

// MARK: - Token
struct Token: Codable {
    let type: String?
    let token: String?
    //let refreshToken: JSONNull?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case token = "token"
        //case refreshToken = "refreshToken"
    }
}
