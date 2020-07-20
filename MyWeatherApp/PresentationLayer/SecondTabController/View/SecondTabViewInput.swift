//
//  SecondTabViewInput.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol SecondTabViewInput: AnyObject {
    func setupState()
    func onForecastGet(results: DailyForecast)

}
