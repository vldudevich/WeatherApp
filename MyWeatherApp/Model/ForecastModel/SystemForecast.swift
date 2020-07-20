//
//  SystemForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct SystemForecast: Codable {
    var pod: String
    
    private enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.pod = try container.decode(String.self, forKey: .pod)
    }
}
