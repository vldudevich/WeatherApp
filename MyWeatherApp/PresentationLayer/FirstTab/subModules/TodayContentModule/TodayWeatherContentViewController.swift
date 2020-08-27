//
//  FirtstTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreLocation

class TodayWeatherContentViewController: UIViewController {
    
    @IBOutlet private weak var cityTemperatureImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityTemperatureLabel: UILabel!
    
    @IBOutlet private weak var cloudsImageView: UIImageView!
    @IBOutlet private weak var cloudsLabel: UILabel!
    
    @IBOutlet private weak var rainImageView: UIImageView!
    @IBOutlet private weak var rainLabel: UILabel!
    
    @IBOutlet private weak var pressureImageView: UIImageView!
    @IBOutlet private weak var pressureLabel: UILabel!
    
    @IBOutlet private weak var speedImageView: UIImageView!
    @IBOutlet private  weak var speedLabel: UILabel!
    
    @IBOutlet private weak var directionImageView: UIImageView!
    @IBOutlet private weak var directionLabel: UILabel!
    
    @IBOutlet private weak var shareButton: UIButton!
    
    var results: CityWeather!
    
    var output: TodayWeatherContentViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
    }
    
    @IBAction func shareClickTodayWeather(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [cityNameLabel.text, cityTemperatureLabel.text], applicationActivities: nil)
        present(activityController, animated: true)
    }
}

extension TodayWeatherContentViewController: TodayWeatherContentViewInput {
    func setupState() {
        
        setupUI()
    }
    
    func setupUI() {
        
        results.weather.first?.getImage(bigSize: true) { (image) in
            self.cityTemperatureImageView.image = image
        }
        cityNameLabel.text = "\(results.nameCity), \(results.system.country)"
        cityTemperatureLabel.text = "\(Int(results.main.temperature)) С° | \(results.weather[0].main)"

        cloudsImageView.image = UIImage(named: "humidity")
        cloudsLabel.text = "\(results.main.humidity)%"

        rainImageView.image = UIImage(named: "drop")
        rainLabel.text = "\(results.clouds.all) mm"

        pressureImageView.image = UIImage(named: "thermometer")
        pressureLabel.text = "\(results.main.pressure) hPa"

        speedImageView.image = UIImage(named: "wind")
        speedLabel.text = "\(results.wind.speed) km/h"

        directionImageView.image = UIImage(named: "wind-rose")
        directionLabel.text = results.wind.degreeToString
    }
}
