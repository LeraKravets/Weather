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

    func saveWeatherInfo(currentInfo: [String: Any], dailyInfo: [String: Any]) {
        let locationInfo = currentInfo["coord"] as? [String: Any]
        let latitude = locationInfo?["lat"] as? Double
        let longitude = locationInfo?["lon"] as? Double

        let countryInfo = currentInfo["sys"] as? [String: Any]
        let countryId = countryInfo?["id"] as? Int16
        let countryName = countryInfo?["country"] as? String
        let sunrise = countryInfo?["sunrise"] as? Int64
        let sunset = countryInfo?["sunset"] as? Int64
        

        guard let cityId = currentInfo["id"] as? Int64 else { return }
        let cityName = currentInfo["name"] as? String
        let cityTime = currentInfo["dt"] as? Int
        let cityTimeZone = currentInfo["timezone"] as? Int64

        let currentWeatherInfo = currentInfo["weather"] as? [[String: Any]]
        let currentIconInfo = currentWeatherInfo?.first
        let currentWeatherIcon = currentIconInfo?["icon"] as? String
        let summary = currentIconInfo?["main"] as? String
        let currentMainInfo = currentInfo["main"] as? [String: Any]
        let currentTemp = currentMainInfo?["temp"] as? Double
        let humidity = currentMainInfo?["humidity"] as? Double
        let pressure = currentMainInfo?["pressure"] as? Double
        let tempMin = currentMainInfo?["temp_min"] as? Double
        let tempMax = currentMainInfo?["temp_max"] as? Double

        let visibility = currentInfo["visibility"] as? Double
        let wind = currentInfo["wind"] as? [String: Any]
        let windSpeed = wind?["speed"] as? Double



        guard let dailyWeatherInfo = dailyInfo["data"] as? [[String: Any]] else { return }

//        Saving/updating City Entity

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
        city?.weatherIcon = currentWeatherIcon
        if let cityTimeZone = cityTimeZone {
            city?.timezone = cityTimeZone
        }

//        Saving/updating Country Entity

        if city?.country == nil {
            city?.country = NSEntityDescription.insertNewObject(forEntityName: "Country",
                                                                into: context) as? Country
        }
        city?.country?.countryName = countryName
        if let countryId = countryId {
            city?.country?.countryId = countryId
        }

//        Saving/updating Location Entity

        if city?.location == nil {
            city?.location = NSEntityDescription.insertNewObject(forEntityName: "Location",
                                                               into: context) as? Location
        }
        if let latitude = latitude, let longitude = longitude {
            city?.location?.latitude = latitude
            city?.location?.longitude = longitude
        }

//        Saving/updating CurrentWeather Entity

        if city?.currentWeather == nil {
            city?.currentWeather = NSEntityDescription.insertNewObject(forEntityName: "CurrentWeather", into: context) as? CurrentWeather
        }
        city?.currentWeather?.currentIcon = currentWeatherIcon
        city?.currentWeather?.summary = summary
        if let currentTemp = currentTemp, let tempMin = tempMin, let tempMax = tempMax, let humidity = humidity, let pressure = pressure, let visibility = visibility, let windSpeed = windSpeed, let sunset = sunset, let sunrise = sunrise {
            city?.currentWeather?.currentTemp = currentTemp.convertToCelsiusAndRound()
            city?.currentWeather?.tempMin = tempMin.convertToCelsiusAndRound()
            city?.currentWeather?.tempMax = tempMax.convertToCelsiusAndRound()
            city?.currentWeather?.humidity = round(humidity)
            city?.currentWeather?.pressure = round(pressure)
            city?.currentWeather?.visibility = (visibility / 1000).roundToDecimal(1)
            city?.currentWeather?.windSpeed = round(windSpeed)
            city?.currentWeather?.sunset = sunset
            city?.currentWeather?.sunrise = sunrise
        }
//        var dailyWeather: DailyWeather?

        for item in city?.dailyWeathert ?? [] {
            context.delete(item as! NSManagedObject)
        }

        for oneDayWeather in dailyWeatherInfo {
            let dailyWeather = NSEntityDescription.insertNewObject(forEntityName: "DailyWeather",
                                                                   into: context) as? DailyWeather
            let dailyTempMin = oneDayWeather["min_temp"] as? Double
            let dailyTempMax = oneDayWeather["max_temp"] as? Double
            let dailyWeatherDate = oneDayWeather["ts"] as? Int64
            let dailyWeatherAdditionalInfo = oneDayWeather["weather"] as? [String: Any] ?? [:]
            let dailyWeatherIcon = dailyWeatherAdditionalInfo["icon"] as? String

            if let dailyTempMin = dailyTempMin, let dailyTempMax = dailyTempMax, let dailyWeatherDate = dailyWeatherDate, let dailyWeatherIcon = dailyWeatherIcon, let dailyWeather = dailyWeather {
                dailyWeather.tempMin = Int64(Int(round(dailyTempMin)))
                dailyWeather.tempMax = Int64(Int(round(dailyTempMax)))
                dailyWeather.date = dailyWeatherDate
                dailyWeather.dailyIcon = dailyWeatherIcon
                city?.addToDailyWeathert(dailyWeather)
            }
        }
        print(city?.dailyWeathert)

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

    func getDateFromStamp(timeInterval: Int) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        let dateFormat = "EEEEEEEEEE, yyyy, MMM dd"  //hh:mm
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
