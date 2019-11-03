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

    lazy var myPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: view.frame.maxY - 60, width: UIScreen.main.bounds.width, height: 50)
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

    lazy var backToMenu: UIButton = {
        let button = UIButton(frame: CGRect(x: view.frame.maxX - 40, y: view.frame.maxY - 40, width: 20, height: 15))
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

        self.view.addSubview(myPageControl)
        self.view.addSubview(backToMenu)

        self.dataSource = self
        self.delegate = self

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

//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        guard completed else { return }
//        guard let currentVC = pageViewController.viewControllers?.first as? CityVC else {
//            return
//        }
//        guard let cityIndex = arrayCityVC.firstIndex(of: currentVC) else { return }
//        pageControl.currentPage = cityIndex
//    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          guard completed else { return }
          guard let currentVC = pageViewController.viewControllers?.first as? CityVC else {
              return
          }
        guard let index = arrayCityVC.firstIndex(of: currentVC) else { return }
        myPageControl.currentPage = index
      }



//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return cities.count
//    }
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }





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
