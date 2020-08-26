//
//  Wind.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct Wind: Codable  {
    var speed: Double
    var degree: Int
    var degreeToString: String {
        
        switch self.degree {
        case (0..<12),(350..<360):
            return "N"
        case 12..<34:
            return "NNE"
        case 34..<57:
            return "NE"
        case 57..<79:
            return "ENE"
        case 79..<102:
            return "E"
        case 102..<124:
            return "ESE"
        case 124..<147:
            return "SE"
        case 147..<170:
            return "SSE"
        case 170..<191:
            return "S"
        case 191..<214:
            return "SSW"
        case 214..<237:
            return "SW"
        case 237..<260:
            return "WSW"
        case 260..<281:
            return "W"
        case 281..<304:
            return "WNW"
        case 304..<327:
            return "NW"
        case 327..<350:
            return "NNW"
        default:
            return "N"
    }
}
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
