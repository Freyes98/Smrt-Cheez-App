//
//  SeccionUser.swift
//  SmrtCheese
//
//  Created by Francisco on 02/08/22.
//

import Foundation


struct Seccion: Codable {
    let id, nombreApartado: String
    let descripcion: String?
    let queseriaID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nombreApartado = "nombre_apartado"
        case descripcion = "descripcion"
        case queseriaID = "queseria_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Secciones = [Seccion]
