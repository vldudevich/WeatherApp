//
//  FirstTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreData

class FirstTabViewPresenter: FirstTabViewOutput {
    
    weak var view: FirstTabViewInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
    
    func loadDataFromBD() {
        
        let fetchRequest:
            NSFetchRequest<City> = City.fetchRequest()

        do {
            let currentPage = try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            for cities in currentPage.reversed() {
                loadWeatherData(cityToSearch: cities.name ?? "")
            }
        } catch {}
    }
    
    func getTodayData(cityToSearch: String) {
        getWeatherData(cityToSearch: cityToSearch)
    }
    
    private func getWeatherData(cityToSearch: String) {
        let dataManager = DataManager()
        dataManager.getWeatherData(cityToSearch: cityToSearch) { (results) in
            let page = UIStoryboard(name: "TodayWeatherContentViewController", bundle: nil).instantiateViewController(withIdentifier: "TodayWeatherContentViewController") as? TodayWeatherContentViewController
            page?.results = results
            let city = City(context: PersistenceService.shared.persistentContainer.viewContext)
            city.name = cityToSearch
            PersistenceService.shared.saveContext()
//
            self.view.onWeatherPageGet(results: page!)
        }
    }
    
    private func loadWeatherData(cityToSearch: String) {
        let dataManager = DataManager()
        dataManager.getWeatherData(cityToSearch: cityToSearch) { (results) in
            let page = UIStoryboard(name: "TodayWeatherContentViewController", bundle: nil).instantiateViewController(withIdentifier: "TodayWeatherContentViewController") as? TodayWeatherContentViewController
            page?.results = results
            self.view.onWeatherPageGet(results: page!)
        }
    }
}

