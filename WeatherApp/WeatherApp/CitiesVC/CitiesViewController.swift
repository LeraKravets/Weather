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

    var weatherItems: [CurrentWeather] = PersistenceManager.shared.fetchCurrentWeather()
    var cityInfo: [City] = PersistenceManager.shared.fetchCityInfo()


    private let cityCellID = "CityCellID"
    private let addCityCellId = "AddCityCellID"

    private enum Sections: Int, CaseIterable {
        case cityInfo
        case newCity
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Helper Methods

    func loadData(cityName: String) {
        NetworkManager.shared.loadCurrentWeather(targetCity: cityName) { [weak self] (weatherInformation) in
            //            self?.weatherItems = weatherInformation ?? [:]
            guard let self = self, let weatherCurrentInfo = weatherInformation else { return }
            // save data to BD
            PersistenceManager.shared.saveCurrentWeatherInfo(info: weatherCurrentInfo)
            // get data from BD
            self.weatherItems = PersistenceManager.shared.fetchCurrentWeather()
            self.cityInfo = PersistenceManager.shared.fetchCityInfo()
            // update ui
            DispatchQueue.main.async {
//                self.newsTabelView.reloadData()
//                self.storiesCollectionView.reloadData()
//                self.activityIndicator.stopAnimating()
//            }
                    self.citiesTableView.reloadData()
        	}
        }
    }

    func goToSearch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        searchVC.searchDelegate = self
        self.present(searchVC, animated: true, completion: nil)
    }

	// MARK: - Actions

}

	// MARK: - UITableViewDataSource

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
            cell.delegate = self
            cell.update(with: weatherItems[indexPath.row], and: cityInfo[indexPath.row])
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
            citiesTableView.reloadData()
        }
    }
}

extension CitiesViewController: SearchViewControllerDelegate {

    func didSelectCity(cityName: String) {
        self.loadData(cityName: cityName)
    }
}
