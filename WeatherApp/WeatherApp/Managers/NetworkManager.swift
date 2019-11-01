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

//    func loadCurrentWeather(targetCity: String, completionHandler: @escaping ([String: Any]?) -> Void) {
//        let resourceString =  "https://api.openweathermap.org/data/2.5/weather?q=\(targetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"
//
//        guard let resourceURL = URL(string: resourceString) else { fatalError() }
//
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, error) in
//            guard let jsonData = data, error == nil else { return }
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? [String: Any] else { return }
//                print(json)
//                completionHandler(json)
//            } catch {
//                print(error)
//            }
//        }
//        dataTask.resume()
//    }
//
//    func loadDailyWeather(targetCity: String, completionHandler: @escaping ([String: Any]?) -> Void) {
//        let resourceString =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(targetCity)&key=b883a022667c489090772840866e0102"
//
//        guard let resourceURL = URL(string: resourceString) else { fatalError() }
//
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, error) in
//            guard let jsonData = data, error == nil else { return }
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? [String: Any] else { return }
//                print(json)
//                completionHandler(json)
//            } catch {
//                print(error)
//            }
//        }
//        dataTask.resume()
//    }




//let operationQueue: OperationQueue = OperationQueue()
//
//    func downloadWeather(targetCity: String, completionHandler: @escaping ([String: Any]?) -> Void) {
//
//
//
//        let resourceString =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(targetCity)&key=b883a022667c489090772840866e0102"
//
//        guard let resourceURL = URL(string: resourceString) else { fatalError() }
//
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, error) in
//            guard let jsonData = data, error == nil else { return }
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                    as? [String: Any] else { return }
//                print(json)
//                completionHandler(json)
//            } catch {
//                print(error)
//            }
//        }
//        dataTask.resume()
//    }

    func downloadWeatherData(targetCity: String, completionHandler: @escaping ([String: Any]?, [String: Any]?) -> Void) {
        let resourceString1 =  "https://api.openweathermap.org/data/2.5/weather?q=\(targetCity)&APPID=5fd0c255bfc224e83c8160bb7241d760"
        let resourceString2 =  "https://api.weatherbit.io/v2.0/forecast/daily?city=\(targetCity)&key=b883a022667c489090772840866e0102&days=7"

        guard let resourceURL1 = URL(string: resourceString1) else { fatalError() }
        guard let resourceURL2 = URL(string: resourceString2) else { fatalError() }

        let dataTask = URLSession.shared.dataTask(with: resourceURL1) { (data, _, error) in
            guard let jsonData = data, error == nil else { return }
            do {
                guard let json1 = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    as? [String: Any] else { return }
                print(json1)
                let dataTask = URLSession.shared.dataTask(with: resourceURL2) { (data, _, error) in
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
                dataTask.resume()
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}
