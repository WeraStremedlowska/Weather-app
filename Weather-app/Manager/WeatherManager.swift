//
//  WeatherManager.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import Foundation
import Alamofire

enum WeatherError: Error, LocalizedError {
    
    case unknown
    case invalidCity
    case custom(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "This is an invalid city. Please try again."
        case .unknown:
            return "This is an unknown error!"
        case .custom(let description):
            return description
        }
    }
}

struct WeatherManager {
        
    private let API_KEY = "19990688e82bc411110e04f530338e8a"
        
    func fetchWeather(byCity city: String, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        
        let guery = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
        let urlString = String(format: path, guery, API_KEY)
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) {(response) in
            switch response.result {            
            case .success(let weatherData):
                let model = weatherData.model
                completion(.success(model))
            case .failure(let error):
                if let err = self.getWeatherError(error: error, data: response.data) {
                    completion(.failure(err))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getWeatherError(error: AFError, data: Data?) -> Error? {
        if error.responseCode == 404,
           let data = data,
           let failure = try? JSONDecoder().decode(WeatherDataFailure.self, from: data) {
           let message = failure.message
           return WeatherError.custom(description: message)
        } else {
            return nil
        }
    }
}
