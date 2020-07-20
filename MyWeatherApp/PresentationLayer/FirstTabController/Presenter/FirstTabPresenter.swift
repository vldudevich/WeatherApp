//
//  FirstTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class FirstTabPresenter: FirstTabViewOutput {
    
    weak var view: FirstTabViewInput!
    
    func onViewDidLoad(with cityToSearch: String) {
        getWeatherData(cityToSearch: cityToSearch)
        view.setupState()
    }
    
    private func getWeatherData(cityToSearch: String) {
        DataManager.sharedManager.getWeatherData(cityToSearch: cityToSearch) { (weather) in
            self.view.onWeatherGet(results: weather)
        }
    }
}
