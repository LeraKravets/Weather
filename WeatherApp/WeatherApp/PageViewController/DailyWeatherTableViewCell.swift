//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 10/26/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateDailyWeather(dailyWeatherInfo: DailyWeather) {
        if let iconName = dailyWeatherInfo.dailyIcon {
            weatherIconImageView.image = UIImage(named: iconName)
        }
        print(dailyWeatherInfo.dailyIcon)
        maxTempLabel.text = String(dailyWeatherInfo.tempMax)
        minTempLabel.text = String(dailyWeatherInfo.tempMin)
        if let timezone = dailyWeatherInfo.city?.timezone {
            weekDayLabel.text = (dailyWeatherInfo.date).TimeFormatter(timeFormat: .dayOfWeek, timeZone: timezone)
        }
    }
}
