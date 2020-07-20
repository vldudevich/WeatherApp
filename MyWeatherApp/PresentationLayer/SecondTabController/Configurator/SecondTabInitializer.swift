//
//  SecondTabInitializer.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SecondTabInitializer: NSObject {
    
    @IBOutlet var viewController: SecondTabViewController!
    
    override func awakeFromNib() {
        let configurator = SecondTabConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
