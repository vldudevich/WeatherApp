//
//  System.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct System: Codable  {
    
    var type: Int
    var indentifier: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case indentifier = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(Int.self, forKey: .type)
        self.indentifier = try container.decode(Int.self, forKey: .indentifier)
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
