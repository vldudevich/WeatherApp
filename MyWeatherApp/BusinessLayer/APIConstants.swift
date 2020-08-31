//
//  APIConstants.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

enum APIConstants: String {
    case apiKey = "appid"
    case apiKeyValue = "d4458b0662163707e0e4df2c0aceecb1"
    case baseURL = "api.openweathermap.org"
    case weatherURL = "/data/2.5/weather"
    case dailyForecastURL = "/data/2.5/forecast"
    case imageURL = "http://openweathermap.org/img/wn/"
}
