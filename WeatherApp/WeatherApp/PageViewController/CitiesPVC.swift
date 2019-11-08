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
    var initialIndex: Int?

    lazy var citiesNumberPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        guard arrayCityVC.count != 1 else { return pageControl }
        pageControl.numberOfPages = cities.count
        if let pageControlIndex = initialIndex {
            pageControl.currentPage = pageControlIndex
        }
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        return pageControl
    }()

    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(citiesNumberPageControl)
        self.view.addSubview(menuButton)

        self.dataSource = self
        self.delegate = self

        guard let index = initialIndex else { return }
        setViewControllers([arrayCityVC[index]], direction: .forward, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let guide = view.safeAreaLayoutGuide
        citiesNumberPageControl.translatesAutoresizingMaskIntoConstraints = false
        citiesNumberPageControl.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -15).isActive = true
        citiesNumberPageControl.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -25).isActive = true
        menuButton.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -15).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20).isActive = true


    }

	// MARK: - Create VC
    lazy var arrayCityVC: [CityVC] = {
        var citiesVC = [CityVC]()
        for city in cities {
            if let cityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityVC") as? CityVC {
                cityVC.city = city
                citiesVC.append(cityVC)
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
    }

    @objc func backToMenuButtonTapped(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
     }
}

extension CitiesPVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard arrayCityVC.count != 1 else { return nil }
        guard let currentVC = viewController as? CityVC else { return nil }
        guard let index = arrayCityVC.firstIndex(of: currentVC) else { return nil }
        let previousCityIndex = index - 1
        if previousCityIndex >= 0 {
            return arrayCityVC[previousCityIndex]
        } else {
            return arrayCityVC.last
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard arrayCityVC.count != 1 else { return nil }
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

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          guard completed else { return }
          guard let currentVC = pageViewController.viewControllers?.first as? CityVC else {
              return
          }
        guard let index = arrayCityVC.firstIndex(of: currentVC) else { return }
        citiesNumberPageControl.currentPage = index
      }
}
