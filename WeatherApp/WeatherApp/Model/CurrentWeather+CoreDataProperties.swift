//
//  CurrentWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 11/4/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import CoreData
import Foundation

extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "CurrentWeather")
    }

    @NSManaged public var currentIcon: String?
    @NSManaged public var currentTemp: Double
    @NSManaged public var humidity: Double
    @NSManaged public var pressure: Double
    @NSManaged public var summary: String?
    @NSManaged public var tempMax: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var visibility: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var city: City?

}
