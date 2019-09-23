//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Лера on 9/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
//    private let ApiKey = "1dd60096c7aeeef497dea519ecf26df5"

    private init() {}

    func loadForecast(city: String, completionHandler: @escaping ([String: Any]?) -> Void) {
        let resourceString =  "https://community-open-weather-map.p.rapidapi.com/weather?q=\(city)"

        let headers = [
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
            "x-rapidapi-key": "469d7e00ffmsh86117e6c69776edp1fd2cajsnfb722761cf8e"
        ]
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        var request = URLRequest(url: resourceURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let jsonData = data, error == nil else { return }
//            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                as? [String: Any] else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    as? [String: Any] else { return }
//                let weatherResponse = try JSONDecoder().decode(WeatherItems.self, from: jsonData)
                print(json)
                completionHandler(json)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}
