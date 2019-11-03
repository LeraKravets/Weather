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
        searchQueue.addOperation { [weak self] in
        guard let self = self else { return }
        let results = self.info.filter { $0.starts(with: text) }

            DispatchQueue.main.async {
                completion(results)
            }
        }
    }

    private let info = ["Mina, United States",
    "Mina, United States",
    "Minatare, United States",
    "MINBUN, Australia",
    "Minburn, United States",
    "Minco, United States",
    "Mindelo, Cape Verde",
    "Minden City, United States",
    "Minden, United States",
    "Minden, United States",
    "Minden, United States",
    "Minden, United States"]
    
}
