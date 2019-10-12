//
//  PersistenceManager.swift
//  WeatherApp
//
//  Created by Лера on 9/28/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation
import CoreData

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

        guard let cityId = info["id"] as? Int else { return }
        let cityName = info["name"] as? String
        let cityTime = info["dt"] as? Double

        let currentWeatherInfo = info["weather"] as? [[String: Any]]
        let currentIconInfo = currentWeatherInfo?[0] as? [String: Any]
        let currentIcon = currentIconInfo?["icon"] as? String
        let summary = currentIconInfo?["main"] as? String
        let currentMainInfo = info["main"] as? [String: Any]
        let currentTemp = currentMainInfo?["temp"] as? Double
        let humidity = currentMainInfo?["humidity"] as? Double
        let pressure = currentMainInfo?["pressure"] as? Double
        let tempMin = currentMainInfo?["temp_min"] as? Double
        let tempMax = currentMainInfo?["temp_max"] as? Double

		// Saving/updating City Entity

        var city: City?

		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.predicate = NSPredicate(format: "cityId = %li", cityId)
        do {
            let cities = try? context.fetch(request) as? [City]
			city = cities?.first
        }

        if city == nil {
            city = NSEntityDescription.insertNewObject(forEntityName: "City",
                                                       into: context) as? City
        }
        city?.cityName = cityName
        city?.cityId = cityId
        if let cityTime = cityTime {
            city?.time = getDateFromStamp(timeInterval: cityTime)
        }

        // Saving/updating Country Entity

        let country = NSEntityDescription.insertNewObject(forEntityName: "Country",
                                                          into: context) as? Country
        country?.countryName = countryName
        if let countryId = countryId {
            country?.countryId = countryId
        }

        // Saving/updating Location Entity

        if city?.location == nil {
            city?.location = NSEntityDescription.insertNewObject(forEntityName: "Location",
                                                               into: context) as? Location
        }
        if let latitude = latitude, let longitude = longitude {
            city?.location?.latitude = latitude
            city?.location?.longitude = longitude
        }

        // Saving/updating CurrentWeather Entity

        if city?.currentWeather == nil {
            city?.currentWeather = NSEntityDescription.insertNewObject(forEntityName: "CurrentWeather", into: context) as? CurrentWeather
        }
        city?.currentWeather?.currentIcon = currentIcon
        city?.currentWeather?.summary = summary
        if let currentTemp = currentTemp, let tempMin = tempMin, let tempMax = tempMax, let humidity = humidity, let pressure = pressure {
            city?.currentWeather?.currentTemp = currentTemp - 273.15
            city?.currentWeather?.tempMin = tempMin - 273.15
            city?.currentWeather?.tempMax = tempMax - 273.15
            city?.currentWeather?.humidity = humidity
            city?.currentWeather?.pressure = pressure
        }

//        let currentWeather = NSEntityDescription.insertNewObject(forEntityName: "CurrentWeather", into: context) as? CurrentWeather
//        currentWeather?.currentIcon = currentIcon
//        currentWeather?.summary = summary
//        if let currentTemp = currentTemp, let tempMin = tempMin, let tempMax = tempMax, let humidity = humidity, let pressure = pressure {
//            currentWeather?.currentTemp = currentTemp - 273.15
//            currentWeather?.tempMin = tempMin - 273.15
//            currentWeather?.tempMax = tempMax - 273.15
//            currentWeather?.humidity = humidity
//            currentWeather?.pressure = pressure
//        }


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


    // MARK: - Core Data Deleting support

    func deleteCityInfoItem(in array: inout [City], by index: Int) {
        let item = array[index]
        context.delete(item)
//        array.remove(at: index)
        saveContext()
    }

    func deleteWeatherInfoItem(in array: inout [CurrentWeather], by index: Int) {
        let item = array[index]
        context.delete(item)
        saveContext()
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

    // MARK: - Helper methods

    func getDateFromStamp(timeInterval: Double) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        let dateFormat = "hh:mm" //EEEEEEEEEE, yyyy, MMM dd
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
