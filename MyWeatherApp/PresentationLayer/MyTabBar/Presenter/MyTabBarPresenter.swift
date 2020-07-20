//
//  MyTabBarPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MyTabBarPresenter: MyTabBarViewOutput {
    
    weak var view: MyTabBarViewInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
}
