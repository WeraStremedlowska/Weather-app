//
//  AddCityViewController.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 13.02.23.
//

import UIKit

class AddCityViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var countryTextField: UITextField!
    
    private let weatherManager = WeatherManager()
    
    weak var delegate: WeatherViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()        
    }
//
//
//    cityTextField.accessibilityIdentifier =
//        AccessibilityIdentifiers.AddCityViewController.cityTextField
//    countryTextField.accessibilityIdentifier =
//        AccessibilityIdentifiers.AddCityViewController.countryTextField
//    searchButton.accessibilityIdentifier =
//        AccessibilityIdentifiers.AddCityViewController.searchButton
//    statusLabel.accessibilityIdentifier =
//        AccessibilityIdentifiers.AddCityViewController.statusLabel
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityTextField.becomeFirstResponder()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        statusLabel.isHidden = true
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
//        statusLabel.isHidden = true
        guard let queryCountry = countryTextField.text, !queryCountry.isEmpty else {
            showSearchError(text: "Country cannot be empty.")
            return }
        guard let queryCity = cityTextField.text, !queryCity.isEmpty else {
            showSearchError(text: "Please provide City name.")
            return }
                handleSearch(queryCity: queryCity, queryCountry: queryCountry)
                return
    }
    
    private func showSearchError(text: String) {
        statusLabel.isHidden = false
        statusLabel.textColor = .systemRed
        statusLabel.text = text
    }
    
    private func handleSearch(queryCity: String, queryCountry: String) {
        view.endEditing(true)
        activityIndicatorView.startAnimating()
        weatherManager.fetchWeather(byCity: queryCity, byCountry: queryCountry) { [weak self] (result) in
            guard let this = self else { return }
            this.activityIndicatorView.stopAnimating()
            switch result {
            case .success(let model):
                this.handleSearchSuccess(model: model)
            case .failure(let error):
                this.showSearchError(text: error.localizedDescription)
            }
        }
    }
    
    private func handleSearchSuccess(model: WeatherModel) {
        statusLabel.isHidden = false
        statusLabel.textColor = .systemGreen
        statusLabel.text = "Success!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let this = self else { return }
            this.delegate?.didUpdateWeatherFromSearch(model: model)
        }
    }
}

extension AddCityViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}


