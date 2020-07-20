//
//  List.swift
//  MyWeatherApp
//
//  Created by vladislav on 10.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct ListForecast: Codable {
    
    static var dataFormaterHourMinute: DateFormatter = {
        var format = DateFormatter()
        format.dateFormat = "HH:mm"
        return format
    }()
    
    static var dataFormaterDays: DateFormatter = {
        var format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format
    }()
    
    var dataTime: Int
    var mainForecast: MainForecast
    var weatherForecast: [WeatherForecast]
    var clouds: CloudsForecast
    var windForecast: WindForecast
    var systemForecast: SystemForecast
    var dateText: String
    var customForecastDate: String {
        let dateSource = Self.dataFormaterDays.date(from: dateText)
        let hourlyDate = Self.dataFormaterHourMinute.string(from: dateSource!)
        
        return hourlyDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case dataTime = "dt"
        case mainForecast = "main"
        case weatherForecast = "weather"
        case clouds = "clouds"
        case windForecast = "wind"
        case systemForecast = "sys"
        case dateText = "dt_txt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dataTime = try container.decode(Int.self, forKey: .dataTime)
        self.mainForecast = try container.decode(MainForecast.self, forKey: .mainForecast)
        self.weatherForecast = try container.decode([WeatherForecast].self, forKey: .weatherForecast)
        self.clouds = try container.decode(CloudsForecast.self, forKey: .clouds)
        self.windForecast = try container.decode(WindForecast.self, forKey: .windForecast)
        self.systemForecast = try container.decode(SystemForecast.self, forKey: .systemForecast)
        self.dateText = try container.decode(String.self, forKey: .dateText)
    }
}
