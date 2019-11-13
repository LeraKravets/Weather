//
//  SearchManager.swift
//  WeatherApp
//
//  Created by Лера on 11/2/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

protocol SearchManager {
    func performSearch(text: String, completion: @ escaping ([String]) -> Void)
}

class SearchNamagers {
//    static var enthernetConnection = true
    static func chooseSearchManager() -> SearchManager {
        if Reachability.isConnectedToNetwork() == false {
            return RemoteSearch()
        } else {
            return LocalSearchManager()
        }
    }
}
