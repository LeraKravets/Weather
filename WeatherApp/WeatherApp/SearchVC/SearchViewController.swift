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
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchDelegate?.didSelectCity(cityName: searchResults[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch(searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
