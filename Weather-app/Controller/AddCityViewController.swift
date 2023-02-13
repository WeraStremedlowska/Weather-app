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
    
    private func setupViews() {
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        cityTextField.becomeFirstResponder()
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
    }
}

extension AddCityViewContreller: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}
