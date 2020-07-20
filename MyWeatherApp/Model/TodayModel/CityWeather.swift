//
//  Weather.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct CityWeather: Codable {
    
    static func parseResponse( responseData: Data, completionHandler: (CityWeather) -> Void) {
        let decoder = JSONDecoder()
        do {
            let moviesResponse = try decoder.decode(CityWeather.self, from: responseData)
            completionHandler(moviesResponse)
        } catch {
            print(error)
        }
    }
    
    var coordinate: Coordinate
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int?
    var wind: Wind
    var clouds: Clouds
    var dataTime: Int
    var system: System
    var timezone: Int
    var indentifier: Int
    var nameCity: String
    var code: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case coordinate = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dataTime = "dt"
        case system = "sys"
        case timezone = "timezone"
        case indentifier = "id"
        case nameCity = "name"
        case code = "cod"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.base = try container.decode(String.self, forKey: .base)
        self.main = try container.decode(Main.self, forKey: .main)
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        self.wind = try container.decode(Wind.self, forKey: .wind)
        self.clouds = try container.decode(Clouds.self, forKey: .clouds)
        self.dataTime = try container.decode(Int.self, forKey: .dataTime)
        self.system = try container.decode(System.self, forKey: .system)
        self.timezone = try container.decode(Int.self, forKey: .timezone)
        self.indentifier = try container.decode(Int.self, forKey: .indentifier)
        self.nameCity = try container.decode(String.self, forKey: .nameCity)
        self.code = try container.decode(Int.self, forKey: .code)
    }
}
