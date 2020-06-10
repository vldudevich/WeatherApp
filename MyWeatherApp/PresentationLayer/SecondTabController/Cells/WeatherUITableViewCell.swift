//
//  WeatherUITableViewCell.swift
//  MyWeatherApp
//
//  Created by vladislav on 09.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class WeatherUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var daylyImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let indentifier = "WeatherUITableViewCell"
}
