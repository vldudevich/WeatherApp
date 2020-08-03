//
//  HeaderDailyForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class HeaderDailyForecast: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
    func configure(for section: Int) {
        
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"

        for item in 0...section {
            if section == 0 {
                headerLabel.text = "Today"
            } else if section == 1 {
                headerLabel.text = "Tomorrow"
            } else {
                let nextDayDate = calendar.date(byAdding: .day, value: item, to: date)!
                let myDate = dateFormater.string(from: nextDayDate)
                headerLabel.text = myDate
            }
        }
    }
}
