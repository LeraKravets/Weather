//
//  CurrentWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 10/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import Foundation
import CoreData


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
    @NSManaged public var city: City?

}
