//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 10/26/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak fileprivate var weekDayLabel: UILabel!
    @IBOutlet weak fileprivate var weatherIconImageView: UIImageView!
    @IBOutlet weak fileprivate var maxTempLabel: UILabel!
    @IBOutlet weak fileprivate var minTempLabel: UILabel!

    // MARK: - Life Cycle
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
        print(dailyWeatherInfo.dailyIcon as Any)
        maxTempLabel.text = String(dailyWeatherInfo.tempMax)
        minTempLabel.text = String(dailyWeatherInfo.tempMin)
        if let timezone = dailyWeatherInfo.city?.timezone {
            weekDayLabel.text = (dailyWeatherInfo.date).timeFormatter(timeFormat: .dayOfWeek, timeZone: timezone)
        }
    }
}
