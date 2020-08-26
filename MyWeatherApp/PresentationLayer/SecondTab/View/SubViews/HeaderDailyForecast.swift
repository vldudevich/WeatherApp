//
//  HeaderDailyForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class HeaderDailyForecast: UITableViewHeaderFooterView {

    @IBOutlet weak var headerButton: UIButton!
    
    func configure(for section: Int) {
        
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        for item in 0...section {
            if section == 0 {
                headerButton.setTitle("Today", for: .normal)
            } else if section == 1 {
                headerButton.setTitle("Tomorrow", for: .normal)
            } else {
                let nextDayDate = calendar.date(byAdding: .day, value: item, to: date)!
                let myDate = dateFormater.string(from: nextDayDate)
                headerButton.setTitle(myDate, for: .normal)
            }
        }
    }
    
}
