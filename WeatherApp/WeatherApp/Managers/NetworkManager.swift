//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Лера on 9/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Alamofire
import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

// With Alamofire
    func downloadWeatherData(targetCity: String, completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
        let formattedtargetCity = targetCity.encodedCityName
        let urlStringCurrent =  "https://api.openweathermap.org/data/2.5/weather?q=\(formattedtargetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"

        AF.request(urlStringCurrent).responseJSON { response in
            switch response.result {
            case .success(let json):
                guard let currentWeather = json as? [String: Any] else {
                    print("Result value in response is nil")
                    completionHandler(nil, nil)
                    return
                }
                self.loadDailyWeather(targetCity: targetCity, currentWeather: currentWeather, completionHandler: completionHandler)
            case .failure(let error):
                print("Error result: \(error)")
                completionHandler(nil, nil)
                return
            }
        }
    }

// With URLSession
//    func downloadWeatherData(targetCity: String, completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
//          let formattedtargetCity = targetCity.encodedCityName
//          let resourceString =  "https://api.openweathermap.org/data/2.5/weather?q=\(formattedtargetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"
//
//          guard let resourceURL = URL(string: resourceString) else {
//              completionHandler(nil, nil)
//              return
//          }
//
//          let dataTask = URLSession.shared.dataTask(with: resourceURL) { [weak self] (data, _, error) in
//              guard let self = self, let jsonData = data, error == nil else { return }
//              do {
//                  guard let currentWeather = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                      as? [String: Any] else { return }
//                  print(currentWeather)
//                  self.loadDaily(targetCity: targetCity, currentWeather: currentWeather, completionHandler: completionHandler)
//              } catch {
//                  print(error)
//              }
//          }
//          dataTask.resume()
//      }

// With Alamofire
    func loadDailyWeather(targetCity: String, currentWeather: [String: Any], completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
        let formattedtargetCity = targetCity.encodedCityName
        let urlStringDaily =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(formattedtargetCity)&key=b883a022667c489090772840866e0102&days=7"
        AF.request(urlStringDaily).responseJSON { response in
            switch response.result {
            case .success(let json):
                guard let dailyWeather = json as? [String: Any] else {
                    print("Result value in response is nil")
                    completionHandler(nil, nil)
                    return
                }
                completionHandler(currentWeather, dailyWeather)
            case .failure(let error):
                print("Error result: \(error)")
                completionHandler(nil, nil)
                return
            }
        }
    }

// With URLSession
//    func loadDailyWeather(targetCity: String, currentWeather: [String: Any], completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
//        let formattedtargetCity = targetCity.encodedCityName
//        let resourceString2 =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(formattedtargetCity)&key=b883a022667c489090772840866e0102&days=7"
//        guard let resourceURL2 = URL(string: resourceString2) else { fatalError() }
//
//        let dataTask = URLSession.shared.dataTask(with: resourceURL2) { (data, _, error) in
//            guard let jsonData = data, error == nil else { return }
//            do {
//                guard let dailyWeather = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? [String: Any] else { return }
//                print(dailyWeather)
//                completionHandler(currentWeather, dailyWeather)
//            } catch {
//                print(error)
//            }
//        }
//        dataTask.resume()
//    }
}

extension String {
    var encodedCityName: String {
        return replacingOccurrences(of: " ", with: "%20")
    }
}
