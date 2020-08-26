//
//  FirstTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreLocation

class FirstTabViewPresenter: FirstTabViewOutput {
    weak var view: FirstTabViewInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
    
    func getTodayData(cityToSearch: String) {
        
        view.setupState()
        getWeatherData(cityToSearch: cityToSearch)
    }
    
    private func getWeatherData(cityToSearch: String) {
        DataManager.sharedManager.getWeatherData(cityToSearch: cityToSearch) { (results) in
            let page = UIStoryboard(name: "TodayWeatherContentViewController", bundle: nil).instantiateViewController(withIdentifier: "TodayWeatherContentViewController") as? TodayWeatherContentViewController
            page?.results = results
            Utils.cities.append(cityToSearch)
            self.view.onWeatherPageGet(results: page!)
        }
        
    }
}

