//
//  SecondTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreLocation

class SecondTabViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var test = [Int]()
    var forecast = [ListForecast]()
    
    @IBOutlet weak var dailyTableView: UITableView!

    private var cityToSearch = "Taganrog"
    
    var output: SecondTabViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: "HeaderDailyForecast", bundle: Bundle.main)
        dailyTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderDailyForecast")
        output.onViewDidLoad(cityToSearch: cityToSearch)
        dailyTableView.reloadData()
    }
    
    private func updateTable() {
        API.sharedManager.getDailyForecast(cityToSearch: cityToSearch,  success: { (data) in
            DailyForecast.parseResponse(responseData: data) { (weather) in
            }
        }) { (error) in
            print(error)
        }
    }
}

extension SecondTabViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test[section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "hello"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherUITableViewCell.indentifier) as! WeatherUITableViewCell
        cell.configureCell(forecast: forecast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dailyTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SecondTabViewController: SecondTabViewInput {

    func onForecastGet(results: DailyForecast) {
        forecast = results.list
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"

        var dateSource = dateFormater.date(from: results.list[0].dateText)
        dateFormater.dateFormat = "yyyy-MM-dd"
        var lastDate = dateFormater.string(from: dateSource!)
        var count = 0
        var count2 = 0
        for item in results.list {
            if (item.dateText.contains(lastDate)) {
                count += 1
            } else {
                count2 += 1
                dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"

                dateSource = dateFormater.date(from: item.dateText)
                dateFormater.dateFormat = "yyyy-MM-dd"
                
                lastDate = dateFormater.string(from: dateSource!)
                test.append(count)
                
                count = 0
            }
        }
        print(count)
        dailyTableView.reloadData()
    }
        
    func setupState() {
        
        self.navigationItem.title = "Forecast"
        
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}

extension SecondTabViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print(location.coordinate)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                // City
                if let city = placeMark.subAdministrativeArea {
                    self.cityToSearch = city
                }
        })
    }
}
