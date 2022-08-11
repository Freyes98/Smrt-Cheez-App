//
//  SensorUser.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import Foundation


struct SensorEnc: Encodable {
    
    let nombre_sensor, tipo: String?
    let pines: [Int]?
    let descripcion, imagen: String?
    let token: String?
}



struct Sensor: Codable {
    let id, nombreSensor, tipo: String?
    let pines: [Int]?
    let descripcion, imagen, apartadoID, createdAt: String?
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nombreSensor = "nombre_sensor"
        case tipo, pines, descripcion, imagen
        case apartadoID = "apartado_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Sensores = [Sensor]
