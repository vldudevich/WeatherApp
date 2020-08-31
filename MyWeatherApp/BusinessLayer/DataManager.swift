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
    
    func getWeatherData(cityToSearch: String, succes: @escaping (_ weather: CityWeather) -> Void) {
        let api = API()
        api.getWeatherByName(cityToSearch: cityToSearch, success: { (data) in
            api.parseResponse(responseData: data) { (weather) in
                succes(weather)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getDailyForeast(cityToSearch: String, success: @escaping (_ forecast: DailyForecast) -> Void) {
        let api = API()
        api.getDailyForecast(cityToSearch: cityToSearch, success: { (data) in
            api.parseResponse(responseData: data) { (forecast) in
                success(forecast)
            }
        }) { (error) in
            print(error)
        }
    }
    
}
