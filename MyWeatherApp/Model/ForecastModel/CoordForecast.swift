//
//  CoordForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct CoordForecast: Codable {
    
    var latitude: Double
    var longtitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longtitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.longtitude = try container.decode(Double.self, forKey: .longtitude)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
    }
}
