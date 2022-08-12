//
//  SensorValues.swift
//  SmrtCheese
//
//  Created by Francisco on 11/08/22.
//

import Foundation

struct lastValue: Decodable {
    let id: String
    let value: Double
    let sensorID: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case value = "value"
        case sensorID = "sensor_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
struct Value: Codable {
    let id: String
    let value: Double
    let sensorID: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case value = "value"
        case sensorID = "sensor_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


typealias Values = [Value]
