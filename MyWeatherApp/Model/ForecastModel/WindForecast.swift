//
//  WindForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct WindForecast: Codable {
    
    var speed: Double
    var degree: Int
    
    private enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case degree = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.degree = try container.decode(Int.self, forKey: .degree)
    }
}
