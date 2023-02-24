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
    case invalidCountry
    case custom(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "This is an invalid city. Please try again."
        case .invalidCountry:
            return "This is an invalid country. Please try again."
        case .unknown:
            return "This is an unknown error!"
        case .custom(let description):
            return description
        }
    }
}

struct WeatherManager {
        
    private let API_KEY = "19990688e82bc411110e04f530338e8a"
    private let cacheManager = CacheManager()
    
    //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
    func fetchWeather(lat: Double, lon: Double, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        let path = "https://api.openweathermap.org/data/2.5/weather?appid=%@&units=metric&lat=%f&lon=%f"
        let urlString = String(format: path, API_KEY, lat, lon)
        handleRequest(urlString: urlString, completion: completion)
    }
    
    //api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={your api key}
    func fetchWeather(byCity city: String, byCountry country: String, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        let gueryCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let gueryCountry = country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? country
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@,%@&appid=%@&units=metric"
        let urlString = String(format: path, gueryCity, gueryCountry, API_KEY)
        
        handleRequest(urlString: urlString, completion: completion)
    }
    
    private func handleRequest(urlString: String, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: WeatherData.self, queue: .main,
                               decoder: JSONDecoder()) {(response) in
            switch response.result {
            case .success(let weatherData):
                let model = weatherData.model
                self.cacheManager.cacheCityCountry(cityName: model.cityName, countryName: model.countryName)
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
