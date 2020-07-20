//
//  FirstTabViewInput.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol FirstTabViewInput: AnyObject {
    
    func setupState()
    func onWeatherGet(results: CityWeather)
}
