//
//  LocalSearchManager.swift
//  WeatherApp
//
//  Created by Лера on 11/2/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

class LocalSearchManager: SearchManager {
    private let searchQueue: OperationQueue

    init() {
        searchQueue = OperationQueue()
        searchQueue.maxConcurrentOperationCount = 1
        searchQueue.name = "LocalSearchQueue"
    }

    func performSearch(text: String, completion: @escaping ([String]) -> Void) {
        searchQueue.cancelAllOperations()
        searchQueue.addOperation {
            guard let url = Bundle.main.url(forResource: "city.list.min", withExtension: "json") else { fatalError() }
            do {
                let jsonData = try Data(contentsOf: url)
                guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] else { return }
                let citiesNameArr = json.compactMap({ $0["name"] }) as? [String] ?? []
                let results = citiesNameArr.filter({ $0.starts(with: text) })

                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print(error)
            }

        }
    }
}
