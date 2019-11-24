//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 9/17/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak fileprivate var cityNameLabel: UILabel!
    @IBOutlet weak fileprivate var temperatureLabel: UILabel!
    @IBOutlet weak fileprivate var backgroundImageView: UIImageView!

    // MARK: - Properties

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Life Cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(cityItem: City) {
        if let currentTemp = cityItem.currentWeather?.currentTemp {
            temperatureLabel.text = String(Int(currentTemp))
        }
        cityNameLabel.text = cityItem.cityName
        guard let backgroundImage = cityItem.weatherIcon else { return }
        switch backgroundImage {
        case "03d":
            backgroundImageView.image = UIImage(named: "04d")
        case "03n":
            backgroundImageView.image = UIImage(named: "04n")
        case "10d":
            backgroundImageView.image = UIImage(named: "09d")
        case "10n":
            backgroundImageView.image = UIImage(named: "09n")
        default:
            backgroundImageView.image = UIImage(named: backgroundImage)
        }
    }

    // MARK: - Actions

}
