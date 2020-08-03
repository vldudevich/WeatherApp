//
//  FirtstTabViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreLocation

class FirstTabViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
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
    private let cityVC = SuggestionsTableViewController()
    private var results: CityWeather?
    private var cityToSearch = "Taganrog"
    private var mySearchController = UISearchController()
    var output: FirstTabViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityVC.delegate = self
        output.onViewDidLoad(with: cityToSearch)
    }
    
    @IBAction func pressToShare(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [cityNameLabel.text ?? "city", cityTemperatureLabel.text ?? "temperature", cityTemperatureImageView.image!], applicationActivities: nil)
        self.present(activityController, animated: true)
    }

}

extension FirstTabViewController: FirstTabViewInput {
    func setupState() {
        navigationItem.title = "Today"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouchUpInside))
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let myVController = SuggestionsTableViewController()
        myVController.delegate = self
    }
    @objc func addButtonTouchUpInside() {
        
        guard let myVC = UIStoryboard(name: "SuggestionsTableViewController", bundle: nil).instantiateInitialViewController() else { return }

        self.present(myVC, animated:true, completion: nil)
        
    }
    
    func onWeatherGet(results: CityWeather) {
        self.results = results
        
        results.weather[0].getImage(bigSize: true) { (image) in
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
extension FirstTabViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print(location.coordinate)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                // City
                if let city = placeMark.subAdministrativeArea {
                    self.cityToSearch = city
                }
        })
    }
}

extension FirstTabViewController: SuggestionsTableResultDelegate {
    func shareCityTouchUpInside(_ city: String) {
        print(city)
    }
    
}
