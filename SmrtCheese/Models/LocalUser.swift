//
//  LocalUser.swift
//  SmrtCheese
//
//  Created by Francisco on 27/07/22.
//

import Foundation
struct Local: Encodable {
    
    let nombre_queseria: String?
    let telefono: String?
    let direccion: String?
    let horarios: String?
    let descripcion: String?
    let token: String?
}

struct Queseria: Codable {
    let id, nombreQueseria, telefono: String?
    let direccion: String?
    let horarios, descripcion, userID, createdAt: String?
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nombreQueseria = "nombre_queseria"
        case telefono, direccion, horarios, descripcion
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Locales = [Queseria]
