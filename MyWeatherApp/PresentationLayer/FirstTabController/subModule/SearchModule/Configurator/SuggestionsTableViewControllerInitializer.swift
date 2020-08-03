//
//  SearchResultTableViewControllerInitializer.swift
//  MyWeatherApp
//
//  Created by vladislav on 31.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class SuggestionsTableViewControllerInitializer: NSObject {
    
    @IBOutlet var viewController: SuggestionsTableViewController!
    
    override func awakeFromNib() {
        let configurator = SuggestionsTableConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
    
}
