//
//  WeatherItems.swift
//  WeatherApp
//
//  Created by Лера on 9/19/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

class WeatherItems {

    // MARK: - Variables

    var cityName: String?
    var currentTime: String?
    var currentTemp: Double?
    var currentIcon: String?
    var currentSummary: String?
    var dailyTime: String?
    var dailyHighTemp: Double?
    var dailyLowTemp: Double?
    var dailyIcon: String?

    init(weatherInfo: [String: Any]) {
		self.cityName = weatherInfo["timezone"] as? String
        if let currentInfo = weatherInfo["currently"] as? [String: Any] {
            self.currentTime = currentInfo["time"] as? String
            self .currentTemp = currentInfo["temperature"] as? Double
            self.currentIcon = currentInfo["icon"] as? String
			self.currentSummary = currentInfo["summary"] as? String
        }
        if let dailyInfo = weatherInfo["daily"] as? [String: Any] {
            self.dailyTime = dailyInfo["time"] as? String
            self.dailyHighTemp = dailyInfo["temperatureHigh"] as? Double
            self.dailyLowTemp = dailyInfo["temperatureLow"] as? Double
            self.dailyIcon = dailyInfo["icon"] as? String
        }
    }
}
