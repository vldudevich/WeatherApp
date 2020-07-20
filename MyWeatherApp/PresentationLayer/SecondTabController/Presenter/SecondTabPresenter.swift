//
//  SecondTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SecondTabPresenter: SecondTabViewOutput {
    
    weak var view: SecondTabViewInput!
    
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
    
    func onViewDidLoad(cityToSearch: String) {
        getDailyForecastData(cityToSearch: cityToSearch)
        view.setupState()
    }
    
    private func getDailyForecastData(cityToSearch: String) {
        DataManager.sharedManager.getDailyForeast(cityToSearch: cityToSearch) { (forecast) in
            self.view.onForecastGet(results: forecast)
        }
    }
    
}
