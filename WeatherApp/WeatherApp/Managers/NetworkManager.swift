//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Лера on 9/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

typealias CurrentWheather = [String: Any]
typealias DailyWheather = [String: Any]
typealias Completion = (CurrentWeather?, DailyWeather?) -> Void

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

//    func downloadWeatherData(targetCity: String, completionHandler: @escaping Completion) {
    func downloadWeatherData(targetCity: String, completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
        let formattedtargetCity = targetCity.encodedCityName
        let resourceString =  "https://api.openweathermap.org/data/2.5/weather?q=\(formattedtargetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"

        guard let resourceURL = URL(string: resourceString) else {
			completionHandler(nil, nil)
            return
        }

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { [weak self] (data, _, error) in
            guard let self = self, let jsonData = data, error == nil else { return }
            do {
                guard let currentWeather = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? CurrentWeather else { return }
                	as? [String: Any] else { return }
                print(currentWeather)
                self.loadDaily(targetCity: targetCity, currentWeather: currentWeather, completionHandler: completionHandler)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

    func loadDaily(targetCity: String, currentWeather: [String: Any], completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
//    func loadDaily(targetCity: String, currentWeather: CurrentWeather, completionHandler: @escaping Completion) {

        let formattedtargetCity = targetCity.encodedCityName
        let resourceString2 =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(formattedtargetCity)&key=b883a022667c489090772840866e0102&days=7"
        guard let resourceURL2 = URL(string: resourceString2) else { fatalError() }

        let dataTask = URLSession.shared.dataTask(with: resourceURL2) { (data, _, error) in
            guard let jsonData = data, error == nil else { return }
            do {
                guard let dailyWeather = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? DailyWeather else { return }
                    as? [String: Any] else { return }
                print(dailyWeather)
                completionHandler(currentWeather, dailyWeather)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

}

extension String {

    var encodedCityName: String {
        return replacingOccurrences(of: " ", with: "%20")
    }

}
