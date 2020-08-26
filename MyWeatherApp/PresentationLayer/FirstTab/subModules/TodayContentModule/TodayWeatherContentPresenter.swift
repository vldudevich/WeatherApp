//
//  TodayWeatherContentPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.08.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TodayWeatherContentPresenter: TodayWeatherContentViewOutput {

    weak var view: TodayWeatherContentViewInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
}
