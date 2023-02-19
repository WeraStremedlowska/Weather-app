//
//  ViewController.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import UIKit
import SkeletonView
import CoreLocation
import Loaf

protocol WeatherViewControllerDelegate: class {
    func didUpdateWeatherFromSearch(model: WeatherModel)
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationButton: UIBarButtonItem!
    @IBOutlet weak var addCityButton: UIBarButtonItem!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let defaultCity = "London"
    private let defaultCountry = "GB"
    private let weatherManager = WeatherManager()
    private let cacheManager = CacheManager()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        locationButton.accessibilityIdentifier = AccessibilityIdentifiers.WeatherViewController.locationButton
//        addCityButton.accessibilityIdentifier = AccessibilityIdentifiers.WeatherViewController.addCityButton
//        conditionImageView.accessibilityIdentifier = AccessibilityIdentifiers.WeatherViewController.conditionImageView
//        temperatureLabel.accessibilityIdentifier = AccessibilityIdentifiers.WeatherViewController.temperatureLabel
//        conditionLabel.accessibilityIdentifier = AccessibilityIdentifiers.WeatherViewController.conditionLabel
        
        let city = displayedCity()
        let country = displayedCountry()
        
        fetchWeatherWhenOpenApp(byCity: city, byCountry: country)
        
    }
    
    private func displayedCity() -> String {
        let city = cacheManager.getCachedCity() ?? defaultCity
        return city
    }
    
    private func displayedCountry() -> String {
        let country = cacheManager.getCachedCity() ?? defaultCountry
        return country
    }
    
    private func fetchWeatherWhenOpenApp(byCity city: String, byCountry country: String) {
        showAnimation()
        weatherManager.fetchWeather(byCity: city, byCountry: country) { [weak self] (result) in
            guard let this = self else { return }
            this.handleLocationWhenOpenApp(result)
        }
        
    }
    
    private func fetchWeather(byLocation location: CLLocation) {
        showAnimation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        weatherManager.fetchWeather(lat: lat, lon: lon) { [weak self] (result) in
            guard let this = self else { return }
            this.handleResult(result)
        }
    }
    
    private func fetchWeather(byCity city: String, byCountry country: String) {
        showAnimation()
        weatherManager.fetchWeather(byCity: city, byCountry: country) { [weak self] (result) in
            guard let this = self else { return }
            this.handleResult(result)
        }
    }
    
    private func handleResult(_ result: Result<WeatherModel, Error>) {
        switch result {
        case .success(let model):
            updateView(with: model)
            print(result)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        hideAnimation()
        conditionImageView.image = UIImage(named: "imSad")
        navigationItem.title = ""
        temperatureLabel.text = "Oops!"
        conditionLabel.text = "Something went wrong.\nPlease define location."
        Loaf(error.localizedDescription, state: .error, location: .bottom, sender: self).show()
    }
        
        private func handleLocationWhenOpenApp(_ result: Result<WeatherModel, Error>) {
            switch result {
            case .success(let model):
                updateView(with: model)
                print(result)
            case .failure(let error):
                handleLocationErrorWhenOpenApp(error)
            }
        }
        
        private func handleLocationErrorWhenOpenApp(_ error: Error) {
            let city = defaultCity
            let country = defaultCountry
            showAnimation()
            weatherManager.fetchWeather(byCity: city, byCountry: country) { [weak self] (result) in
                guard let this = self else { return }
                this.handleResult(result)
            }
        }
    
    private func updateView(with model: WeatherModel) {
        hideAnimation()
        temperatureLabel.text = model.temp.toString().appending("°C")
        conditionLabel.text = model.conditionDescription
        navigationItem.title = (model.cityName + ", " + model.countryName)
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
    
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddCity" {
            if let destination = segue.destination as? AddCityViewController {
                destination.delegate = self
            }
        }
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        default:
            promptForLocationPermission()
        }
    }
    
    private func promptForLocationPermission() {
        let alertController = UIAlertController(
            title: "Requires Location Permission",
            message: "Would you like to enable location permission in Settings?",
            preferredStyle: .alert)
        let enableActoin = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(enableActoin)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherViewController: WeatherViewControllerDelegate {
    
    func didUpdateWeatherFromSearch(model: WeatherModel) {
        presentedViewController?.dismiss(animated: true, completion: { [weak self] in
            guard let this = self else { return }
            this.updateView(with: model)            
        })
        
    }
}

extension WeatherViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            fetchWeather(byLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleError(error)
    }
}

