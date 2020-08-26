//
//  FirstTabInitializer.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class FirstTabInitializer: NSObject {
    
    @IBOutlet private weak var viewController: FirstTabViewController!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let configurator = FirstTabConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
