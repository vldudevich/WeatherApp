//
//  SecondTabViewOutput.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol SecondTabViewOutput {
    func onViewDidLoad()
    func onViewWillApear()
    func getForecastData(cityToSearch: String)
}
