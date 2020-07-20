//
//  FirstTabConfigurator.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class FirstTabConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? FirstTabViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: FirstTabViewController) {

        let presenter = FirstTabPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
