//
//  CityForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct CityForecast: Codable {
    
    var indentifier: Int
    var nameCity: String
    var coordinate: CoordForecast
    var country: String
    var population: Int
    var timeZone: Int
    var sunRise: Int
    var sunSet: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case indentifier = "id"
        case nameCity = "name"
        case coordinate = "coord"
        case country = "country"
        case population = "population"
        case timeZone = "timezone"
        case sunRise = "sunrise"
        case sunSet = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.indentifier = try container.decode(Int.self, forKey: .indentifier)
        self.nameCity = try container.decode(String.self, forKey: .nameCity)
        self.coordinate = try container.decode(CoordForecast.self, forKey: .coordinate)
        self.country = try container.decode(String.self, forKey: .country)
        self.population = try container.decode(Int.self, forKey: .population)
        self.timeZone = try container.decode(Int.self, forKey: .timeZone)
        self.sunRise = try container.decode(Int.self, forKey: .sunRise)
        self.sunSet = try container.decode(Int.self, forKey: .sunSet)
    }
}
