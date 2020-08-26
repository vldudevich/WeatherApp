//
//  MainForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct MainForecast: Codable {
    
    var temperature: Double
    var feelsLike: Double
    var minTemperature: Double
    var maxTemperature: Double
    var pressure: Int
    var seaLevel: Int
    var groundLevel: Int
    var humidity: Int
    var koefTemperature: Float
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity = "humidity"
        case koefTemperature = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.minTemperature = try container.decode(Double.self, forKey: .minTemperature)
        self.maxTemperature = try container.decode(Double.self, forKey: .maxTemperature)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.seaLevel = try container.decode(Int.self, forKey: .seaLevel)
        self.groundLevel = try container.decode(Int.self, forKey: .groundLevel)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.koefTemperature = try container.decode(Float.self, forKey: .koefTemperature)
    }
}
