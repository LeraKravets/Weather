//
//  PersistanceManager.swift
//  WeatherApp
//
//  Created by Лера on 9/28/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import CoreData
import Foundation

class PersistenceManager {

    static let shared = PersistenceManager()

    private init() {}

    func saveCurrentWeatherInfo(info: [String: Any]) {
        print(info)
        let locationInfo = info["coord"] as? [String: Any]
        let latitude = locationInfo?["lat"] as? Double
        let longitude = locationInfo?["lon"] as? Double

        let countryInfo = info["sys"] as? [String: Any]
        let countryId = countryInfo?["id"] as? Int16
        let countryName = countryInfo?["country"] as? String

        let cityId = info["id"] as? Int16
        let cityName = info["name"] as? String

        let currentWeatherInfo = info["weather"] as? [String: Any]
        let currentIcon = currentWeatherInfo?["icon"] as? String
        let summary = currentWeatherInfo?["main"] as? String
        let currentMainInfo = info["main"] as? [String: Any]
        let currentTemp = currentMainInfo?["temp"] as? Double
        let humidity = currentMainInfo?["humidity"] as? Double
        let pressure = currentMainInfo?["pressure"] as? Double
        let tempMin = currentMainInfo?["temp_min"] as? Double
        let tempMax = currentMainInfo?["temp_max"] as? Double

        let city = NSEntityDescription.insertNewObject(forEntityName: "City",
                                                       into: context) as? City
        city?.cityName = cityName
        if let cityId = cityId {
            city?.cityId = cityId
        }

        let country = NSEntityDescription.insertNewObject(forEntityName: "Country",
                                                          into: context) as? Country
        country?.countryName = countryName
        if let countryId = countryId {
            country?.countryId = countryId
        }

        let location = NSEntityDescription.insertNewObject(forEntityName: "Location",
                                                           into: context) as? Location
        if let latitude = latitude, let longitude = longitude {
            location?.latitude = latitude
            location?.longitude = longitude
        }

        let currentWeather = NSEntityDescription.insertNewObject(forEntityName: "CurrentWeather", into: context) as? CurrentWeather
        currentWeather?.currentIcon = currentIcon
        currentWeather?.summary = summary
        if let currentTemp = currentTemp, let tempMin = tempMin, let tempMax = tempMax, let humidity = humidity, let pressure = pressure {
            currentWeather?.currentTemp = currentTemp
            currentWeather?.tempMin = tempMin
            currentWeather?.tempMax = tempMax
            currentWeather?.humidity = humidity
            currentWeather?.pressure = pressure
        }
        saveContext()
    }

    // MARK: - Core Data Fetching support

    func fetchCurrentWeather() -> [CurrentWeather] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentWeather")
        do {
            let item = try context.fetch(fetchRequest) as? [CurrentWeather]
            return item ?? []
        } catch let error {
            print(error)
        }
        return []
    }

    func fetchCityInfo() -> [City] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do {
            let item = try context.fetch(fetchRequest) as? [City]
            return item ?? []
        } catch let error {
            print(error)
        }
        return []
    }

    // MARK: - Core Data Context

    var context: NSManagedObjectContext {
        return persistantContainer.viewContext
    }

    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
