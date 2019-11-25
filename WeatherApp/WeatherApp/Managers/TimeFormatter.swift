//
//  TimeFormatter.swift
//  WeatherApp
//
//  Created by Лера on 11/4/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

extension Int64 {
    enum TimeFormat {
        case hourMinutes, dayOfWeek
    }

    func timeFormatter(timeFormat: TimeFormat, timeZone: Int64) -> String {
        let timeZoneDate = self + timeZone
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeZoneDate))
        let dateFormatter = DateFormatter()
        switch timeFormat {
        case .hourMinutes:
            dateFormatter.dateFormat = "hh:mm"
            let dateString = dateFormatter.string(from: date as Date)
            return dateString
        case .dayOfWeek:
            dateFormatter.dateFormat = "E"
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: date as Date)
            let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
            return weekdays[weekDay - 1]
        }
    }
}
