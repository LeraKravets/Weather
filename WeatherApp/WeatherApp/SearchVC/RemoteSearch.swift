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
        currentDataTask?.cancel()
        currentDataTask = nil

        currentDataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
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
