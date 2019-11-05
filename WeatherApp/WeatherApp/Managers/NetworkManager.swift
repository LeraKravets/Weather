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
    private var dataTask: URLSessionDataTask?

    private init() {}

    func downloadWeatherData(targetCity: String, completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
        let formattedtargetCity = targetCity.replacingOccurrences(of: " ", with: "%20")
        let resourceString1 =  "https://api.openweathermap.org/data/2.5/weather?q=\(formattedtargetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"
        let resourceString2 =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(formattedtargetCity)&key=b883a022667c489090772840866e0102&days=3"

        guard let resourceURL1 = URL(string: resourceString1) else { fatalError() }
        guard let resourceURL2 = URL(string: resourceString2) else { fatalError() }

        dataTask?.cancel()
        dataTask = nil

        dataTask = URLSession.shared.dataTask(with: resourceURL1) { (data, _, error) in
            guard let jsonData = data, error == nil else { return }
            do {
                guard let json1 = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    as? [String: Any] else { return }
                print(json1)
                self.dataTask = URLSession.shared.dataTask(with: resourceURL2) { (data, _, error) in
                    guard let jsonData = data, error == nil else { return }
                    do {
                        guard let json2 = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            as? [String: Any] else { return }
                        print(json2)
                        completionHandler(json1, json2)
                    } catch {
                        print(error)
                    }
                }
                self.dataTask?.resume()
            } catch {
                print(error)
            }
        }
        dataTask?.resume()
    }
}
