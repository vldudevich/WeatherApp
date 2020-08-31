//
//  SecondTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import CoreData

class SecondTabPresenter: SecondTabViewOutput {
    
    weak var view: SecondTabViewInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
    
    func onViewWillApear() {
        let fetchRequestFirst:
            NSFetchRequest<CurrentPage> = CurrentPage.fetchRequest()
        var index = 0
        do {
          let currentPage = try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequestFirst)
          index = Int(currentPage.last?.cityIndex ?? 0)
        } catch {}
        
        let fetchRequestSecond:
            NSFetchRequest<City> = City.fetchRequest()

        do {
            let currentPage2 = try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequestSecond)
            getForecastData(cityToSearch: currentPage2[index].name ?? "")
            
        } catch {}
    }
    
    func getForecastData(cityToSearch: String) {
        getDailyForecastData(cityToSearch: cityToSearch)
    }
    
    private func getDailyForecastData(cityToSearch: String) {
        let dataManager = DataManager()
        dataManager.getDailyForeast(cityToSearch: cityToSearch) { (forecast) in
            self.view.onForecastGet(results: forecast)
        }
    }
}
