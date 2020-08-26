//
//  TodayWeatherContentInitializer.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.08.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TodayWeatherContentInitializer: NSObject {
    
    @IBOutlet private var viewController: TodayWeatherContentViewController!
    
    override func awakeFromNib() {
        let configurator = TodayWeatherContentConfigurator()
        configurator.configureModuleForInput(viewInput: viewController)
    }
}
