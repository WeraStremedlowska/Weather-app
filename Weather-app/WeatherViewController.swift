//
//  ViewController.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import UIKit
import SkeletonView

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimation()
        fetchWeather()
        
//        weatherManager.fetchWeather(byCity: "Paris")
    }
    
    private func fetchWeather() {
        
        weatherManager.fetchWeather(byCity: "Berlin") {[weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let model):
                this.updateView(with: model)
            case .failure(let error):
                print("error here: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateView(with model: WeatherModel) {
        hideAnimation()
        temperatureLabel.text = model.temp.toString().appending("°C")
        conditionLabel.text = model.conditionDescription
        navigationItem.title = model.countryName
        conditionImageView.image = UIImage(named: model.conditionImage)

    }
    
    private func hideAnimation() {
        conditionImageView.hideSkeleton()
        temperatureLabel.hideSkeleton()
        conditionLabel.hideSkeleton()
    }
    
    private func showAnimation() {
        conditionImageView.showAnimatedGradientSkeleton()
        temperatureLabel.showAnimatedGradientSkeleton()
        conditionLabel.showAnimatedGradientSkeleton()
    }
    
    @IBAction func addCityButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
    }
}

