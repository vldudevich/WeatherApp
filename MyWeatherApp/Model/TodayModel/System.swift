//
//  System.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct System: Codable  {
    
    var country: String
    var sunrise: Int
    var sunset: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
