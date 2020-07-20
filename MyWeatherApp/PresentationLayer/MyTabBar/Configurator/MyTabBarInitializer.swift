//
//  TabBarInitializer.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MyTabBarInitializer: NSObject {
    
    @IBOutlet weak private var viewController: MyTabBarController!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let configurator = MyTabBarConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
