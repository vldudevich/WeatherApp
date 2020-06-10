//
//  FirtstTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

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
        self.navigationItem.title = "Today"
    }
    
    @IBAction func pressToShare(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [], applicationActivities: nil)
        self.present(activityController, animated: true)
    }
    
    func getWeatherData() {
        API.getWeatherByName(cityToSearch: cityToSearch,  success: { (data) in
            CityWeather.parseResponse(responseData: data) { (weather) in
                guard let data = weather else {return}
                self.results = data
                self.updateData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    func updateData() {

        guard let results = results else {return}
        guard let icon = results.weather[0].icon else {return}
        cityTemperatureImageView.af.setImage(withURL: URL(string: API.getImageUrl(url: icon, bigSize: true))!)
        cityNameLabel.text = "\(results.nameCity), \(results.system.country)"
        cityTemperatureLabel.text = "\(Int(results.main.temperature))С° | \(results.weather[0].main)"

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
