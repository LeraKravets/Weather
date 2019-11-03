//
//  RemoteSearch.swift
//  WeatherApp
//
//  Created by Лера on 11/2/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

class RemoteSearch: SearchManager {

	private var currentDataTask: URLSessionDataTask?

    func performSearch(text: String, completion: @escaping ([String]) -> Void) {
        let formattedCityName = text.replacingOccurrences(of: " ", with: "%20")
        let urlString = "http://gd.geobytes.com/AutoCompleteCity?&template=%3Cgeobytes%20city%3E,%20%3Cgeobytes%20internet%3E&q=" + formattedCityName
        guard let url = URL(string: urlString) else { return }

//        let headers = [
//            "x-rapidapi-host": "andruxnet-world-cities-v1.p.rapidapi.com",
//            "x-rapidapi-key": "469d7e00ffmsh86117e6c69776edp1fd2cajsnfb722761cf8e"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://andruxnet-world-cities-v1.p.rapidapi.com/?query=\(formattedCityName)")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 0.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers




        currentDataTask?.cancel()
        currentDataTask = nil

        currentDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            func performCompletion(_ data: [String]) {
                DispatchQueue.main.async {
                    completion(data)
                }
            }

            guard let data = data, error == nil else {
                performCompletion([])
                return
            }

            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String] else {
                    performCompletion([])
                    return
                }
                performCompletion(json)
            } catch {}
        }
        self.currentDataTask?.resume()
    }
}
