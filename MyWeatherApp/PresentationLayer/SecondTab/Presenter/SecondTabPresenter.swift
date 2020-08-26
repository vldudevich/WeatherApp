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
    
    private func getDailyForecastData(cityToSearch: String) {
        DataManager.sharedManager.getDailyForeast(cityToSearch: cityToSearch) { (forecast) in
            self.view.onForecastGet(results: forecast)
        }
    }
    
    func onViewDidLoad() {
        view.setupState()
    }
    
    func getForecastData(cityToSearch: String) {
        getDailyForecastData(cityToSearch: cityToSearch)
    }
}
