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
    private let resourceString =  "https://api.darksky.net/forecast/1dd60096c7aeeef497dea519ecf26df5/42.3601,-71.0589"

    private init() {}

    func loadForecast(completionHandler: @escaping ([String : Any]?) -> Void) {
        guard let resourceURL = URL(string: resourceString) else { fatalError() }

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, error) in
            guard let dataResponse = data,
                error == nil else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers)
                    as? [String: Any] else { return }
                guard let currentInfo = json["currently"] as? [String: Any] else { return }
                print(currentInfo)
                guard let dailyInfo = json["daily"] as? [String: Any] else { return }
                print(dailyInfo)
                guard let dailyData = dailyInfo["data"] as? [[String: Any]] else { return }
                print(dailyData)
                completionHandler(currentInfo)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }


}
