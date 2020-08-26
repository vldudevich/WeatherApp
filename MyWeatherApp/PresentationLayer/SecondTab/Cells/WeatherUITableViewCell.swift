//
//  WeatherUITableViewCell.swift
//  MyWeatherApp
//
//  Created by vladislav on 09.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class WeatherUITableViewCell: UITableViewCell {
    
    static let indentifier = "WeatherUITableViewCell"
    
    @IBOutlet private weak var daylyImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configureCell(forecast: ListForecast) {
        temperatureLabel.text = "\(Int(forecast.mainForecast.temperature)) С°"
        stateLabel.text = forecast.weatherForecast.first?.main
        timeLabel.text = forecast.customForecastDate
        forecast.weatherForecast[0].getImage(bigSize: true) { (image) in
            self.daylyImageView.image = image
        }
    }
}
