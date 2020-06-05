//
//  FirtstTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController {

    var results: CityWeather?
    var cityToSearch = "Taganrog"
    
    @IBOutlet weak var cityTemperatureImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    
    @IBOutlet weak var cloudsImageView: UIImageView!
    @IBOutlet weak var cloudsLabel: UILabel!
    
    @IBOutlet weak var rainImageView: UIImageView!
    @IBOutlet weak var rainLabel: UILabel!
    
    @IBOutlet weak var pressureImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var speedImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var directionImageView: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
    }
    
    @IBAction func pressToShare(_ sender: Any) {
    }
    
    func getWeatherData() {
        API.getWeatherByName(cityToSearch: cityToSearch,  success: { (data) in
            CityWeather.parseResponse(responseData: data) { (weather) in
                guard let data = weather else {return}
                self.results = data
            }
        }) { (error) in
            print(error)
        }
    }
}
