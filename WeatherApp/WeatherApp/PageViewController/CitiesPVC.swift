//
//  ScrollCitiesPVC.swift
//  WeatherApp
//
//  Created by Лера on 9/18/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CitiesPVC: UIPageViewController {

    var cities = [City]()
    var currentWeather = [CurrentWeather]()
    var dailyWeather = [DailyWeather]()
    var initialIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self

        guard let index = initialIndex else { return }
        setViewControllers([arrayCityVC[index]], direction: .forward, animated: true, completion: nil)
    }
	// MARK: - Create VC
    lazy var arrayCityVC: [CityVC] = {
        var citiesVC = [CityVC]()
        for city in cities {
            if let cityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityVC") as? CityVC {
                cityVC.city = city
                if let index = cities.firstIndex(of: city) {
                    cityVC.currentWeather = currentWeather[index]
                    cityVC.dailyWeather = dailyWeather[index]
                    citiesVC.append(cityVC)
                }
            }
        }
        return citiesVC
    }()

	// MARK: - init PVC
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}

extension CitiesPVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? CityVC else { return nil }
        guard let index = arrayCityVC.firstIndex(of: currentVC) else { return nil }
        if index > 0 {
            return arrayCityVC[index - 1]
        } else if index == 0 {
            return arrayCityVC[cities.count-1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? CityVC else { return nil }
        guard let index = arrayCityVC.firstIndex(of: currentVC) else { return nil }
        let nextCityIndex = index + 1
        if nextCityIndex < cities.count {
            return arrayCityVC[nextCityIndex]
        } else if nextCityIndex == cities.count {
            return arrayCityVC.first
        }
        return nil
    }
}
