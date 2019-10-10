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

    private init() {}

    func loadCurrentWeather(targetCity: String, completionHandler: @escaping ([String: Any]?) -> Void) {
        let resourceString =  "https://api.openweathermap.org/data/2.5/weather?q=\(targetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"

        guard let resourceURL = URL(string: resourceString) else { fatalError() }

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, error) in
            guard let jsonData = data, error == nil else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    as? [String: Any] else { return }
                print(json)
                completionHandler(json)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}
