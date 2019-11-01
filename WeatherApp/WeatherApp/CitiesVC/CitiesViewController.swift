//
//  СitiesViewController.swift
//  WeatherApp
//
//  Created by Лера on 9/17/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var citiesTableView: UITableView!

    // MARK: - Properties

    var currentWeatherItems: [CurrentWeather] = PersistenceManager.shared.fetchCurrentWeather()
    var cityInfo: [City] = PersistenceManager.shared.fetchCityInfo()
//    var dailyWeatherItems: [DailyWeather] = PersistenceManager.shared.fetchDailyWeather()
//    var cityID: [Int16] = []

//    var timer: Timer?


    private let cityCellID = "CityCellID"
    private let addCityCellId = "AddCityCellID"

    private enum Sections: Int, CaseIterable {
        case cityInfo
        case newCity
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        createTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        citiesTableView.reloadData()
    }


    // MARK: - Helper Methods

//    func loadNewCityData(cityName: String) {
//
//        NetworkManager.shared.loadCurrentWeather(targetCity: cityName) { [weak self] (weatherInformation) in
//            guard let self = self, let weatherCurrentInfo = weatherInformation else { return }
//
//            PersistenceManager.shared.saveCurrentWeatherInfo(info: weatherCurrentInfo)
//            self.cityInfo = PersistenceManager.shared.fetchCityInfo()
//            self.currentWeatherItems = PersistenceManager.shared.fetchCurrentWeather()
//
//            DispatchQueue.main.async {
//                self.citiesTableView.reloadData()
//            }
//        }
//    }

//    func loadDailyWeather(cityName: String) {
//
//        NetworkManager.shared.loadDailyWeather(targetCity: cityName) { [weak self] (weatherInformation) in
//            guard let self = self, let weatherCurrentInfo = weatherInformation else { return }
//
//            PersistenceManager.shared.saveDailyWeatherInfo(info: weatherCurrentInfo)
//            self.dailyWeatherItems = PersistenceManager.shared.fetchDailyWeather()
//
//            DispatchQueue.main.async {
//                self.citiesTableView.reloadData()
//            }
//        }
//    }

    func loadWeatherData(cityName: String) {
        NetworkManager.shared.downloadWeatherData(targetCity: cityName) { [weak self] (currentWeather, dailyWeather) in
            guard let self = self, let currentWeather = currentWeather, let dailyWeather = dailyWeather else { return }
            PersistenceManager.shared.saveWeatherInfo(currentInfo: currentWeather, dailyInfo: dailyWeather)
//            PersistenceManager.shared.saveCurrentWeatherInfo(currentWeatherInfo: currentWeather)
//            PersistenceManager.shared.saveDailyWeatherInfo(info: dailyWeather)
            self.currentWeatherItems = PersistenceManager.shared.fetchCurrentWeather()
            self.cityInfo = PersistenceManager.shared.fetchCityInfo()
//            self.dailyWeatherItems = PersistenceManager.shared.fetchDailyWeather()

            DispatchQueue.main.async {
                self.citiesTableView.reloadData()
            }
        }
    }



    func goToSearch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        searchVC.searchDelegate = self
        searchVC.modalPresentationStyle = .fullScreen
        self.present(searchVC, animated: true, completion: nil)
    }

    func goToCity(cities: [City], currentWeather: [CurrentWeather], index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let citiesPVC = storyboard.instantiateViewController(withIdentifier: "CitiesPVC") as? CitiesPVC else { return }
//        let weatherInfo = ["citiesArray": cities, "index": index] as [String : Any]
//        NotificationCenter.default.post(name: CitiesPVC.notificationName, object: nil, userInfo: weatherInfo)
        citiesPVC.cities = cities
        citiesPVC.initialIndex = index
        citiesPVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(citiesPVC, animated: true, completion: nil)
    }
}

extension CitiesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionItem = Sections(rawValue: section) else {
            return 0
        }
        switch sectionItem {
        case .cityInfo: return cityInfo.count
        case .newCity: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionIndex = Sections(rawValue: indexPath.section) else {
            fatalError("Can't find section with index: \(indexPath.section)")
        }
        switch sectionIndex {

        case .cityInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cityCellID, for: indexPath) as? CityTableViewCell
                else {
                    fatalError("Can't find cell with id: \(cityCellID)")
            }
//            cell.delegate = self
            cell.update(currentInfo: currentWeatherItems[indexPath.row], and: cityInfo[indexPath.row])
            return cell

        case .newCity:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addCityCellId, for: indexPath) as? AddCityTableViewCell else {
                    fatalError("Can't find cell with id: \(addCityCellId)")
        	}
            cell.addCityHandler = {
                self.goToSearch()
            }
            return cell
    	}
	}
}

	// MARK: - UITableViewDelegate

extension CitiesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        guard let sectionIndex = Sections(rawValue: indexPath.section) else {
            fatalError("Can't find section with index: \(indexPath.section)")
        }
        switch sectionIndex {
        case .cityInfo:
            goToCity(cities: cityInfo, currentWeather: currentWeatherItems, index: indexPath.row)
            for eachCity in cityInfo {
                if let cityName = eachCity.cityName {
                    self.loadWeatherData(cityName: cityName)
                }
            }
        case .newCity:
            return
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let sectionIndex = Sections(rawValue: indexPath.section) else {
            fatalError("Can't find section with index: \(indexPath.section)")
        }
        switch sectionIndex {
        case .cityInfo:
            return true
        case .newCity:
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistenceManager.shared.deleteCityInfoItem(in: &cityInfo, by: indexPath.row)
            PersistenceManager.shared.deleteCurrentWeatherInfoItem(in: &currentWeatherItems, by: indexPath.row)
//            PersistenceManager.shared.deleteDailyWeatherInfoItem(in: &dailyWeatherItems, by: indexPath.row)
            cityInfo.remove(at: indexPath.row)
            citiesTableView.reloadData()
        }
    }
}

extension CitiesViewController: SearchViewControllerDelegate {

    func didSelectCity(cityName: String) {
        self.loadWeatherData(cityName: cityName)
//        self.loadNewCityData(cityName: cityName)
//        self.loadDailyWeather(cityName: cityName)
    }
}







//extension CitiesViewController {
//    func createTimer() {
//
//        if timer == nil {
//
//            let timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                         target: self,
//                                         selector: #selector(updateTimer),
//                                         userInfo: nil,
//                                         repeats: true)
//            RunLoop.current.add(timer, forMode: .common)
//            timer.tolerance = 0.1
//
//            self.timer = timer
//        }
//    }
//
//    @objc func updateTimer() {
//        guard let visibleRowsIndexPaths = citiesTableView.indexPathsForVisibleRows else { return }
//
//        for indexPath in visibleRowsIndexPaths {
//            if let cell = citiesTableView.cellForRow(at: indexPath) as? CityTableViewCell {
//                loadData(cityName: self.cityInfo[indexPath.row].cityName!)
//            }
//        }
//    }
//}
