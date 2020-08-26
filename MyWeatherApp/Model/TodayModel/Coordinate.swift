//
//  Coordinate.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate: Codable {
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
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longtitude = coordinate.longitude
    }
}

