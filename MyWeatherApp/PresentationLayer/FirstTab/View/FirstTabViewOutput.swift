//
//  FirstTabViewOutput.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol FirstTabViewOutput {
    func onViewDidLoad()
    func getTodayData(cityToSearch: String)
}
