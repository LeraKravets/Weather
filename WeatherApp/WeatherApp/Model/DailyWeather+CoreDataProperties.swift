//
//  DailyWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 10/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import Foundation
import CoreData


extension DailyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyWeather> {
        return NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
    }

    @NSManaged public var dailyIcon: String?
    @NSManaged public var dailyTemp: Double
    @NSManaged public var date: String?
    @NSManaged public var tempMax: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var city: City?

}
