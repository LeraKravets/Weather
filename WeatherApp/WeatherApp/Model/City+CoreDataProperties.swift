//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 10/6/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityId: Int
    @NSManaged public var cityName: String?
    @NSManaged public var time: String?
    @NSManaged public var country: Country?
    @NSManaged public var currentWeather: CurrentWeather?
    @NSManaged public var dailyWeathert: DailyWeather?
    @NSManaged public var location: Location?

}
