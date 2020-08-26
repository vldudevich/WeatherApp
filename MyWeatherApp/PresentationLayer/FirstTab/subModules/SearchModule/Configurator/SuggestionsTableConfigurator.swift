//
//  SearchResultTableConfigurator.swift
//  MyWeatherApp
//
//  Created by vladislav on 31.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SuggestionsTableConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? SuggestionsTableViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: SuggestionsTableViewController) {
        let presenter = SuggestionsTableViewControllerPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
