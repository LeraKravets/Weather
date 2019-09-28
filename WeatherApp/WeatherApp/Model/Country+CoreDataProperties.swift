//
//  Country+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Лера on 9/28/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var countryId: Int16
    @NSManaged public var countryName: String?
    @NSManaged public var city: NSSet?

}

// MARK: Generated accessors for city
extension Country {

    @objc(addCityObject:)
    @NSManaged public func addToCity(_ value: City)

    @objc(removeCityObject:)
    @NSManaged public func removeFromCity(_ value: City)

    @objc(addCity:)
    @NSManaged public func addToCity(_ values: NSSet)

    @objc(removeCity:)
    @NSManaged public func removeFromCity(_ values: NSSet)

}
