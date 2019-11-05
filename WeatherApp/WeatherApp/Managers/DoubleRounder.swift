//
//  DoubleExtention.swift
//  WeatherApp
//
//  Created by Лера on 11/4/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
