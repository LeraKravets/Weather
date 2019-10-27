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
//        weatherIconImageView = dailyWeatherInfo.dailyIcon
        maxTempLabel.text = String(dailyWeatherInfo.tempMax)
        minTempLabel.text = String(dailyWeatherInfo.tempMin)
        weekDayLabel.text = getDateFromStamp(timeInterval: Int(dailyWeatherInfo.date))
    }

    func getDateFromStamp(timeInterval: Int) -> String{
         let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
         let dateFormatter = DateFormatter()
         let dateFormat = "EEEEEEEEEE"  //hh:mm
         dateFormatter.dateFormat = dateFormat
         let dateString = dateFormatter.string(from: date as Date)
         return dateString
     }
}
