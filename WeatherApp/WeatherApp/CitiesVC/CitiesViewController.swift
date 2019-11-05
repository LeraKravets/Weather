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

    var cityInfo: [City] = PersistenceManager.shared.fetchCityInfo()

    private let cityCellID = "CityCellID"
    private let addCityCellId = "AddCityCellID"

    private enum Sections: Int, CaseIterable {
        case cityInfo
        case newCity
    }

    // MARK: - Life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for city in cityInfo {
            if let cityName = city.cityName {
                loadWeatherData(cityName: cityName)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        citiesTableView.reloadData()

    }

    // MARK: - Helper Methods

    func loadWeatherData(cityName: String) {
        NetworkManager.shared.downloadWeatherData(targetCity: cityName) { [weak self] (currentWeather, dailyWeather) in
            guard let self = self, let currentWeather = currentWeather, let dailyWeather = dailyWeather else { return }
            PersistenceManager.shared.saveWeatherInfo(currentInfo: currentWeather, dailyInfo: dailyWeather)
            self.cityInfo = PersistenceManager.shared.fetchCityInfo()
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

    func goToCity(cities: [City], index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let citiesPVC = storyboard.instantiateViewController(withIdentifier: "CitiesPVC") as? CitiesPVC else { return }
        citiesPVC.cities = cities
        citiesPVC.initialIndex = index
        citiesPVC.modalPresentationStyle = .fullScreen
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
            cell.update(cityItem: cityInfo[indexPath.row])
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
        if indexPath.row == 0 {
            return 124.0
        }
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        guard let sectionIndex = Sections(rawValue: indexPath.section) else {
            fatalError("Can't find section with index: \(indexPath.section)")
        }
        switch sectionIndex {
        case .cityInfo:
            goToCity(cities: cityInfo, index: indexPath.row)
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
            cityInfo.remove(at: indexPath.row)
            citiesTableView.reloadData()
        }
    }
}

extension CitiesViewController: SearchViewControllerDelegate {

    func didSelectCity(cityName: String) {
        self.loadWeatherData(cityName: cityName)
    }
}
