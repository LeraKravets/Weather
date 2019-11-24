//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 10/30/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak fileprivate var descriptionLable1: UILabel!
    @IBOutlet weak fileprivate var descriptionLable2: UILabel!
    @IBOutlet weak fileprivate var infoLabel1: UILabel!
    @IBOutlet weak fileprivate var infoLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCurrentWeather(for city: City, by index: Int) {
        let rowType = CityVC.RowType(rawValue: index)
              switch rowType {
              case .sunriseSunset:
                  descriptionLable1.text = "SUNRISE"
                  let timeZone = city.timezone
                  infoLabel1.text = city.currentWeather?.sunrise.timeFormatter(timeFormat: .hourMinutes, timeZone: timeZone)
                  descriptionLable2.text = "SUNSET"
                  infoLabel2.text = city.currentWeather?.sunset.timeFormatter(timeFormat: .hourMinutes, timeZone: timeZone)
              case .pressureHumidity:
                  descriptionLable1.text = "PRESSURE"
                  if let pressure = city.currentWeather?.pressure {
                    infoLabel1.text = String(Int(pressure)) + " hPa"
                  }
                  descriptionLable2.text = "HUMIDITY"
                if let humidity = city.currentWeather?.humidity {
                  infoLabel2.text = String(Int(humidity)) + " %"
                }
              case .windVisibility:
                  descriptionLable1.text = "WIND"
                  if let windSpeed = city.currentWeather?.windSpeed {
                    infoLabel1.text = String(Int(windSpeed)) + " km/h"
                  }
                  descriptionLable2.text = "VISIBILITY"
                if let visibility = city.currentWeather?.visibility {
                  infoLabel2.text = String(Int(visibility)) + " km"
                }
              default:
                  return
        }
    }
}
