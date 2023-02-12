//
//  WeatherManager.swift
//  Weather-app
//
//  Created by Wera Stremedlowska on 11.02.23.
//

import Foundation
import Alamofire

struct WeatherManager {
        
    private let API_KEY = "19990688e82bc411110e04f530338e8a"
    
    
    func fetchWeather(byCity city: String, completion: @escaping(Result<WeatherData, Error>) -> Void) {
        
        let guery = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@units=metric"
        let urlString = String(format: path, guery, API_KEY)
        
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) {(response) in
            switch response.result {            
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
