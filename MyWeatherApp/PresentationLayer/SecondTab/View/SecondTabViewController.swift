//
//  SecondTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class SecondTabViewController: UIViewController {
    
    var test = [Int]()
    var forecast = [ListForecast]()
    
    @IBOutlet private weak var dailyTableView: UITableView!
    
    var output: SecondTabViewOutput!
    
    var hiddenSections = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Utils.indexPage > -1 && Utils.cities.count > 0 {
            output.getForecastData(cityToSearch: Utils.cities[Utils.indexPage])
        }
    }
    
    @objc private func pressForHideSection(sender: UIButton) {
        let section = sender.tag
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<test[section] {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if  hiddenSections.contains(section) {
            hiddenSections.remove(section)
            dailyTableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else if hiddenSections.count != test.count - 1 {
            hiddenSections.insert(section)
            dailyTableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }    }
}

extension SecondTabViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return test[section]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = dailyTableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderDailyForecast") as? HeaderDailyForecast
        myView?.configure(for: section)
        myView?.headerButton.tag = section
        myView?.headerButton.addTarget(self, action: #selector(pressForHideSection(sender:)), for: .touchUpInside)
        return myView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        myView.backgroundColor = .lightGray
        return myView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherUITableViewCell.indentifier) as! WeatherUITableViewCell
        cell.configureCell(forecast: forecast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dailyTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SecondTabViewController: SecondTabViewInput {

    func onForecastGet(results: DailyForecast) {
        forecast = results.list
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"

        var dateSource = dateFormater.date(from: results.list[0].dateText)
        dateFormater.dateFormat = "yyyy-MM-dd"
        var lastDate = dateFormater.string(from: dateSource!)
        var count = 0
        for item in results.list {
            if (item.dateText.contains(lastDate)) {
                count += 1
            } else {
                dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"

                dateSource = dateFormater.date(from: item.dateText)
                dateFormater.dateFormat = "yyyy-MM-dd"
                
                lastDate = dateFormater.string(from: dateSource!)
                test.append(count)
                
                count = 0
            }
        }
        dailyTableView.reloadData()
    }
        
    func setupState() {
        self.navigationItem.title = "Forecast"
        
        let headerNib = UINib.init(nibName: "HeaderDailyForecast", bundle: Bundle.main)
        dailyTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderDailyForecast")
        
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        dailyTableView.estimatedSectionHeaderHeight = 50
    }
}
