//
//  CityVC.swift
//  WeatherApp
//
//  Created by Лера on 9/18/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CityVC: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var dailyWeatherTableView: UITableView!

    enum RowType: Int, CaseIterable {
        case sunriseSunset, pressureHumidity, windVisibility
    }

    var city: City?
    var setOfDailyWeather: Set<DailyWeather>?

    private enum Section: Int, CaseIterable {
        case dailyWeather, currentWeather
    }

    let dailyWeatherCellId = "DailyWeatherCellID"
    let currentWeatherCellId = "CurrentWeatherCellID"


    override func viewDidLoad() {
        setOfDailyWeather = city?.dailyWeathert as? Set<DailyWeather>
        super.viewDidLoad()

        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self

        cityLabel.text = city?.cityName
        summaryLabel.text = city?.currentWeather?.summary
        if let currentTemp = city?.currentWeather?.currentTemp {
            tempLabel.text = String(Int(currentTemp))
        }
        guard let city = city else { return }
        guard let backgroundImage = city.weatherIcon else { return }
        switch backgroundImage {
        case "03d":
            backgroundView.image = UIImage(named: "04d")
        case "03n":
            backgroundView.image = UIImage(named: "04n")
        case "10d":
            backgroundView.image = UIImage(named: "09d")
        case "10n":
            backgroundView.image = UIImage(named: "09n")
        default:
            backgroundView.image = UIImage(named: backgroundImage)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setOfDailyWeather = city?.dailyWeathert as? Set<DailyWeather>
//        arrayOfDailyWeather = setOfDailyWeather?.sorted(by: { $0.date < $1.date })
    }
}

extension CityVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionItem = Section(rawValue: indexPath.section) else {
            return 0
        }
        switch sectionItem {
        case .dailyWeather:
            return 35
        case .currentWeather:
            return 60
        }
    }
}

extension CityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionItem = Section(rawValue: section) else {
            return 0
        }
        switch sectionItem {
        case .dailyWeather:
            return setOfDailyWeather?.count ?? 0
        case .currentWeather:
            return RowType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionIndex = Section(rawValue: indexPath.section) else {
            fatalError("Can't find section with index: \(indexPath.section)")
        }
        switch sectionIndex {
        case .dailyWeather:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: dailyWeatherCellId, for: indexPath) as? DailyWeatherTableViewCell else {
                fatalError("Can't find cell with id: \(dailyWeatherCellId)")
            }
            if let arrayOfDailyWeather = setOfDailyWeather?.sorted(by: { $0.date < $1.date }) {
                cell.updateDailyWeather(dailyWeatherInfo: arrayOfDailyWeather[indexPath.row])
            }
            return cell
        case .currentWeather:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: currentWeatherCellId, for: indexPath) as? CurrentWeatherTableViewCell else {
                fatalError("Can't find cell with id: \(currentWeatherCellId)")
            }
            if let currentCity = city {
                cell.updateCurrentWeather(for: currentCity, by: indexPath.row)
            }
            return cell
        }

    }
}
