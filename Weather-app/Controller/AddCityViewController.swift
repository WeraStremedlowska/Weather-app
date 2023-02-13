//
//  AddCityViewController.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 13.02.23.
//

import UIKit

class AddCityViewContreller: UIViewController{
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
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
        statusLabel.isHidden = true
        guard let query = cityTextField.text, !query.isEmpty else {
            showSearchError(text: "City cannot be empty. Please try again!")
            return }
        searchForCity(query: query)
    }
    
    private func showSearchError(text: String) {
        statusLabel.isHidden = false
        statusLabel.textColor = .systemRed
        statusLabel.text = text
    }
    
    private func searchForCity(query: String) {

    }
}

extension AddCityViewContreller: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}
