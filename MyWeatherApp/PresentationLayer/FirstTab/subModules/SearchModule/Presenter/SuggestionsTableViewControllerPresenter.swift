//
//  SearchResultTableViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 31.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SuggestionsTableViewControllerPresenter: SuggestionsTableViewControllerOutput {
    
    weak var view: SuggestionsTableViewControllerInput!
    
    func onViewDidLoad() {
        view.setupState()
    }
}
