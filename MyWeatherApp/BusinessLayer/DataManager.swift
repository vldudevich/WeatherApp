//
//  DataManager.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static let sharedManager = DataManager()
    
    func getWeatherData(cityToSearch: String, succes: @escaping (_ weather: CityWeather) -> Void) {
        API.sharedManager.getWeatherByName(cityToSearch: cityToSearch, success: { (data) in
            CityWeather.parseResponse(responseData: data) { (weather) in
                succes(weather)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getDailyForeast(cityToSearch: String, success: @escaping (_ forecast: DailyForecast) -> Void) {
        API.sharedManager.getDailyForecast(cityToSearch: cityToSearch, success: { (data) in
            DailyForecast.parseResponse(responseData: data) { (forecast) in
                success(forecast)
            }
        }) { (error) in
            print(error)
        }
    }
}
