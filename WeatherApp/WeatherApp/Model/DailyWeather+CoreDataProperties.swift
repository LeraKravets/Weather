//
//  DailyWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 10/27/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import CoreData
import Foundation

extension DailyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyWeather> {
        return NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
    }

    @NSManaged public var dailyIcon: String?
    @NSManaged public var dailyTemp: Double
    @NSManaged public var date: Int64
    @NSManaged public var tempMax: Int64
    @NSManaged public var tempMin: Int64
    @NSManaged public var city: City?

}
