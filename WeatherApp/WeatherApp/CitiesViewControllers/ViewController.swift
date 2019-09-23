//
//  ViewController.swift
//  WeatherApp
//
//  Created by Лера on 9/17/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Variables
    var weatherItems: [String: Any] = [:]

    public var cities = ["Minsk", "London"]
    private let cityCellID = "CityCellID"
    private let addCityCellId = "AddCityCellID"

    private enum Sections: Int, CaseIterable {
        case cityInfo
        case newCity
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.loadForecast(city: "Minsk") { [weak self] (weatherInformation) in
            self?.weatherItems = weatherInformation ?? [:]
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionItem = Sections(rawValue: section) else {
            return 0
        }
        switch sectionItem {
        case .cityInfo: return cities.count
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
            cell.cityNameLabel.text = cities[indexPath.row]
            cell.temperatureLabel.text = "12"
            return cell
        case .newCity:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addCityCellId, for: indexPath) as? AddCityTableViewCell
                else {
                    fatalError("Can't find cell with id: \(addCityCellId)")
        	}
            return cell
    	}
	}
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
}
