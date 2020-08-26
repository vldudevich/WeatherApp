//
//  Main.swift
//  
//
//  Created by vladislav on 04.06.2020.
//

import Foundation

struct Main: Codable  {
    
    var temperature: Double
    var feelsLike: Double
    var minTemperature: Double
    var maxTemperature: Double
    var pressure: Int
    var humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.minTemperature = try container.decode(Double.self, forKey: .minTemperature)
        self.maxTemperature = try container.decode(Double.self, forKey: .maxTemperature)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}
