//
//  TodayWeatherContentConfigurator.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.08.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TodayWeatherContentConfigurator {
    
    func configureModuleForInput<UIViewController>(viewInput: UIViewController) {
        if let viewContrller = viewInput as? TodayWeatherContentViewController {
            configure(viewController: viewContrller)
        }
    }
    
    private func configure(viewController: TodayWeatherContentViewController) {
        let presenter = TodayWeatherContentPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
