//
//  TabBarConfigurator.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MyTabBarConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? MyTabBarController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: MyTabBarController) {

        let presenter = MyTabBarPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
