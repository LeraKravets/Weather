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

//    var pendingIndex: Int?
//
//    var pageControl = UIPageControl()


//    static let notificationName = NSNotification.Name("MainCitiesVC.passData")

    override func viewDidLoad() {
//        pageControl = UIPageControl(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 50))
//        self.pageControl.numberOfPages = cities.count
//        // self.pageControl.currentPage = 0
//         self.pageControl.tintColor = UIColor.lightGray
//         self.pageControl.pageIndicatorTintColor = UIColor.lightGray
//         self.pageControl.currentPageIndicatorTintColor = UIColor.black
//         pageControl.backgroundColor = UIColor.clear
//         self.view.addSubview(pageControl)



        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
//
//        cities = cscc?.cities ?? []
//        initialIndex = cscc?.initialIndex


        guard let index = initialIndex else { return }
        setViewControllers([arrayCityVC[index]], direction: .forward, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

//    func addObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(CitiesPVC.didReceiveData(_:)), name: CitiesPVC.notificationName, object: nil)
//
//    }
//
//    @objc func didReceiveData(_ notification: Notification) {
//        let weatherInfo = notification.userInfo
//        if let index = weatherInfo?["index"], let citiesArray = weatherInfo?["citiesArray"] {
//            initialIndex = index as? Int
//            cities = citiesArray as? [City] ?? []
//        }
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

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
//        addObservers()
//        fatalError("init(coder:) has not been implemented")
    }
}

extension CitiesPVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? CityVC else { return nil }
        guard let previousCityIndex = arrayCityVC.firstIndex(of: currentVC) else { return nil }
        if previousCityIndex > 0 {
            return arrayCityVC[previousCityIndex - 1]
        } else if previousCityIndex == 0 {
//            return arrayCityVC[cities.count-1]
            return arrayCityVC.last

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

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cities.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        pendingIndex = index(ofAccessibilityElement: (pendingViewControllers.first as? CityVC))
//    }
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            if let currentIndex = pendingIndex {
//                self.pageControl.numberOfPages = currentIndex
//
//
//            }
//        }
//    }


}
