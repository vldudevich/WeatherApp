//
//  CloudsForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct CloudsForecast: Codable {
    var all: Int
    
    private enum CodingKeys: String, CodingKey {
        case all = "all"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.all = try container.decode(Int.self, forKey: .all)
    }
}
