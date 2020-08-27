//
//  HeaderDailyForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class HeaderDailyForecast: UITableViewHeaderFooterView {
    enum HeaderDailyForecastHeaders: String {
        case today
        case tommorow
    }
    @IBOutlet weak var headerButton: UIButton!
    
    func configure(for section: Int) {
        
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        for item in 0...section {
            if section == 0 {
                headerButton.setTitle(HeaderDailyForecastHeaders.today.rawValue.capitalized, for: .normal)
            } else if section == 1 {
                headerButton.setTitle(HeaderDailyForecastHeaders.tommorow.rawValue.capitalized, for: .normal)
            } else {
                let nextDayDate = calendar.date(byAdding: .day, value: item, to: date)!
                let myDate = dateFormater.string(from: nextDayDate)
                headerButton.setTitle(myDate, for: .normal)
            }
        }
    }
    
}
