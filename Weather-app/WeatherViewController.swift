//
//  ViewController.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.featherWeather(city: "Paris")
    }
    
    
    
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func locationButtonTapped(_ sender: Any) {
    }
    

}

