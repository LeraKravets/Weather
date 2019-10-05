//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Лера on 9/30/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

   // MARK: - SearchViewControllerDelegate

protocol SearchViewControllerDelegate: AnyObject {
    func didSelectCity(cityName: String)
}

class SearchViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!

    // MARK: - Properties

    let cellID = "resultsCellId"

    weak var searchDelegate: SearchViewControllerDelegate?

    var citiesInfo: [[String: Any]]? = []
    var citiesNameArr: [String] = []
    var searchCity: [String] = []
    var searching = false

//    var targetCity: String?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loudJsonData(filename: "city.list.min")
    }

    // MARK: - Parsing local JSON file   "city.list.min"

    func loudJsonData(filename fileName: String)  {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { fatalError() }
            do {
                let jsonData = try Data(contentsOf: url)
                guard
                    let json = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]]
                else { return }

                DispatchQueue.main.async {
                    self.citiesInfo = json
                    self.citiesNameArr = self.citiesInfo?.compactMap({ $0["name"] }) as? [String] ?? []
                    self.resultsTableView.reloadData()
                }

            } catch {
                print(error)
            }

        }
    }

//    func loudJsonData(complitionHandler: @escaping ([[String: Any]]?) -> Void) {
//        guard let url = Bundle.main.url(forResource: "city.list.min", withExtension: "json") else { fatalError() }
//        do {
//            let jsonData = try Data(contentsOf: url)
//            guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] else { return }
//            complitionHandler(json)
//        }
//        catch {
//            print(error)
//        }
//    }
}

    // MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCity.count
        } else {
            return citiesNameArr.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SearchTableViewCell
            else {
                fatalError("Can't find cell with id: \(cellID)")
        }
        if searching {
            cell.searchCityLable.text = searchCity[indexPath.row]
        } else {
            cell.searchCityLable.text = citiesNameArr[indexPath.row]
        }
        return cell
    }
}

    // MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            self.searchDelegate?.didSelectCity(cityName: searchCity[indexPath.row])
        } else {
            self.searchDelegate?.didSelectCity(cityName: citiesNameArr[indexPath.row])
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCity = citiesNameArr.filter({ $0.prefix(searchText.count) == searchText })
        searching = true
        resultsTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
