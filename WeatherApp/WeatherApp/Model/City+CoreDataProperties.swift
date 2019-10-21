//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 10/20/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityId: Int64
    @NSManaged public var cityName: String?
    @NSManaged public var time: String?
    @NSManaged public var country: Country?
    @NSManaged public var currentWeather: CurrentWeather?
    @NSManaged public var dailyWeathert: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for dailyWeathert
extension City {

    @objc(addDailyWeathertObject:)
    @NSManaged public func addToDailyWeathert(_ value: DailyWeather)

    @objc(removeDailyWeathertObject:)
    @NSManaged public func removeFromDailyWeathert(_ value: DailyWeather)

    @objc(addDailyWeathert:)
    @NSManaged public func addToDailyWeathert(_ values: NSSet)

    @objc(removeDailyWeathert:)
    @NSManaged public func removeFromDailyWeathert(_ values: NSSet)

}
