//
//  MyTabBarController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    var output: MyTabBarViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
    }
}

extension MyTabBarController: MyTabBarViewInput {
    func setupState() {
    }
}
