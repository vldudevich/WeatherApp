//
//  DailyForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 10.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct DailyForecast: Codable {
    
    static var dataFormaterDays: DateFormatter = {
        var format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format
    }()
    
    static var dataFormaterTime: DateFormatter = {
        var format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format
    }()
    
    var code: String
    var message: Int
    var numberLines: Int
    var list: [ListForecast]
    var city: CityForecast
    
    var countSec: Int {
        var dateSource = Self.dataFormaterDays.date(from: list[0].dateText)
        var lastDate = Self.dataFormaterTime.string(from: dateSource!)
        var count = 0
        var coz = 0
        for item in list {
            if (item.dateText.contains(lastDate)) {
                count += 1
                coz = count
            } else {
                count = 0
                dateSource = Self.dataFormaterDays.date(from: item.dateText)
                
                lastDate = Self.dataFormaterTime.string(from: dateSource!)
            }
        }
        return coz
    }
    
    private enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message = "message"
        case numberLines = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(Int.self, forKey: .message)
        self.numberLines = try container.decode(Int.self, forKey: .numberLines)
        self.list = try container.decode([ListForecast].self, forKey: .list)
        self.city = try container.decode(CityForecast.self, forKey: .city)
    }
}
