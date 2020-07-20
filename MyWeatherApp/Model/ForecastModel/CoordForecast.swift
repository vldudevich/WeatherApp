//
//  CoordForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct CoordForecast: Codable {
    var longtitude: Float
    var latitude: Float
    
    private enum CodingKeys: String, CodingKey {
        case longtitude = "lon"
        case latitude = "lat"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.longtitude = try container.decode(Float.self, forKey: .longtitude)
        self.latitude = try container.decode(Float.self, forKey: .latitude)
    }
}
