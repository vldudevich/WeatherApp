//
//  SecondTabConfigurator.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SecondTabConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? SecondTabViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: SecondTabViewController) {
        let presenter = SecondTabPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
