//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 10/30/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLable1: UILabel!
    @IBOutlet weak var descriptionLable2: UILabel!
    @IBOutlet weak var infoLabel1: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!

//    private enum RowType: Int, CaseIterable {
//        case sunriseSunset, pressureHumidity, windVisibility
//    }

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
                  descriptionLable2.text = "SUNSET"
              case .pressureHumidity:
                  descriptionLable1.text = "PRESSURE"
                  descriptionLable2.text = "HUMIDITY"
              case .windVisibility:
                  descriptionLable1.text = "WIND"
                  descriptionLable2.text = "VISIBILITY"
              default:
                  return

//        let rowType = RowType(rawValue: index)
//        switch rowType {
//        case .sunriseSunset:
//            descriptionLable1.text = "SUNRISE"
//            descriptionLable2.text = "SUNSET"
//        case .pressureHumidity:
//            descriptionLable1.text = "PRESSURE"
//            descriptionLable2.text = "HUMIDITY"
//        case .windVisibility:
//            descriptionLable1.text = "WIND"
//            descriptionLable2.text = "VISIBILITY"
//        default:
//            return
        }

//        if let iconName = dailyWeatherInfo.dailyIcon {
//            weatherIconImageView.image = UIImage(named: iconName)
//        }
//        print(dailyWeatherInfo.dailyIcon)
//        maxTempLabel.text = String(dailyWeatherInfo.tempMax)
//        minTempLabel.text = String(dailyWeatherInfo.tempMin)
//        weekDayLabel.text = getDateFromStamp(Int(dailyWeatherInfo.date))
    }

}
