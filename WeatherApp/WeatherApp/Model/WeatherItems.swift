//
//  WeatherItems.swift
//  WeatherApp
//
//  Created by Лера on 9/19/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

class WeatherItems: Decodable {

    // MARK: - Variables

    var cityName: String?
    var currentData: currentInfo?
    var dailyData: [dailyInfo]?

    enum CodingKeys: String, CodingKey {
        case cityName
        case currentData
        case dailyData
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cityName = try container.decodeIfPresent(String.self, forKey: .cityName)
        self.currentData = try container.decodeIfPresent(currentInfo.self, forKey: .currentData)
        self.dailyData = try container.decodeIfPresent([dailyInfo].self, forKey: .dailyData)
    }


//    init(weatherInfo: Decoder) {
//        let
//        self.cityName = weatherInfo["timezone"] as? String
//        if let currentInfo = weatherInfo["currently"] as? [String: Any] {
//            self.currentTime = currentInfo["time"] as? String
//            self .currentTemp = currentInfo["temperature"] as? Double
//            self.currentIcon = currentInfo["icon"] as? String
//            self.currentSummary = currentInfo["summary"] as? String
//        }
//        if let dailyInfo = weatherInfo["daily"] as? [String: Any] {
//            self.dailyTime = dailyInfo["time"] as? String
//            self.dailyHighTemp = dailyInfo["temperatureHigh"] as? Double
//            self.dailyLowTemp = dailyInfo["temperatureLow"] as? Double
//            self.dailyIcon = dailyInfo["icon"] as? String
//        }
//    }
}

class currentInfo: Decodable {
    var currentTime: String?
    var currentTemp: Double?
    var apparentTemp: Double?
    var currentIcon: String?
    var currentSummary: String?

    enum CodingKeys: String, CodingKey {
        case currentTime
        case currentTemp
        case apparentTemp
        case currentIcon
        case currentSummary
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.currentTime = try container.decodeIfPresent(String.self, forKey: .currentTime)
        self.currentTemp = try container.decodeIfPresent(Double.self, forKey: .currentTemp)
        self.apparentTemp = try container.decodeIfPresent(Double.self, forKey: .apparentTemp)
        self.currentIcon = try container.decodeIfPresent(String.self, forKey: .currentIcon)
        self.currentSummary = try container.decodeIfPresent(String.self, forKey: .currentSummary)
    }
}

class dailyInfo: Decodable {
    var dailyTime: String?
    var dailyHighTemp: Double?
    var dailyLowTemp: Double?
    var dailyIcon: String?

    enum CodingKeys: String, CodingKey {
        case dailyTime
        case dailyHighTemp
        case dailyLowTemp
        case dailyIcon
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dailyTime = try container.decodeIfPresent(String.self, forKey: .dailyTime)
        self.dailyHighTemp = try container.decodeIfPresent(Double.self, forKey: .dailyHighTemp)
        self.dailyLowTemp = try container.decodeIfPresent(Double.self, forKey: .dailyLowTemp)
        self.dailyIcon = try container.decodeIfPresent(String.self, forKey: .dailyIcon)
    }
}
