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
    @IBOutlet weak fileprivate var searchBar: UISearchBar!
    @IBOutlet weak fileprivate var resultsTableView: UITableView!

    // MARK: - Properties
    private var searchMamager: SearchManager { SearchNamagers.chooseSearchManager() }
    private var searchResults: [String] = []

    let cellID = "resultsCellId"

    weak var searchDelegate: SearchViewControllerDelegate?

    var citiesInfo: [[String: Any]]? = []
    var citiesNameArr: [String] = []
    var searchCity: [String] = []
    var searching = false

    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func doSearch(_ text: String?) {
        guard let text = text else { return }
        searchMamager.performSearch(text: text) { [weak self] results in
            self?.searchResults = results
            self?.resultsTableView.reloadData()
        }
    }

    // MARK: - Parsing local JSON file   "city.list.min"

//    func loudJsonData(filename fileName: String)  {
//        DispatchQueue.global().async {
//            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { fatalError() }
//            do {
//                let jsonData = try Data(contentsOf: url)
//                guard
//                    let json = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]]
//                else { return }
//
//                DispatchQueue.main.async {
//                    self.citiesInfo = json
//                    self.citiesNameArr = self.citiesInfo?.compactMap({ $0["name"] }) as? [String] ?? []
//                    self.resultsTableView.reloadData()
//                }
//
//            } catch {
//                print(error)
//            }
//
//        }
//    }

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
//        if searching {
//            return searchCity.count
//        } else {
//            return citiesNameArr.count
//        }
        searchResults.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell

//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SearchTableViewCell
//            else {
//                fatalError("Can't find cell with id: \(cellID)")
//        }
//        if searching {
//            cell.searchCityLable.text = searchCity[indexPath.row]
//        } else {
//            cell.searchCityLable.text = citiesNameArr[indexPath.row]
//        }
//        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchDelegate?.didSelectCity(cityName: searchResults[indexPath.row])
//        if searching {
//            self.searchDelegate?.didSelectCity(cityName: searchCity[indexPath.row])
//        } else {
//            self.searchDelegate?.didSelectCity(cityName: citiesNameArr[indexPath.row])
//        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch(searchText)
//        searchCity = searchResults.filter({ $0.prefix(searchText.count) == searchText })
//        resultsTableView.reloadData()
//        searchCity = citiesNameArr.filter({ $0.prefix(searchText.count) == searchText })
//        searching = true
//        resultsTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

//extension SearchViewController: UISearchResultsUpdating {
//  func updateSearchResults(for searchController: UISearchController) {
//  }
//}
