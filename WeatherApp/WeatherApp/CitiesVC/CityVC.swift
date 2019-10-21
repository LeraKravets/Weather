//
//  CityVC.swift
//  WeatherApp
//
//  Created by Лера on 9/18/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CityVC: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!

    var city: City?
//    var currentWeather: CurrentWeather?
//    var dailyWeather: DailyWeather?


    //    var controllers = [UIViewController]()
//    var currentVCIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        cityLabel.text = city?.cityName
        summaryLabel.text = city?.currentWeather?.summary
        guard let currentTemp = city?.currentWeather?.currentTemp else { return }
//        let dailyTemp = city?.dailyWeathert?.dailyTemp
        tempLabel.text = String(Int(currentTemp))

//        setupPageController()
//
//        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }


//    func setupPageController() {
//
//        guard let pageController = storyboard?.instantiateViewController(withIdentifier: "CitiesPVC") as? CitiesPVC else { return }
//
//        pageController.dataSource = self
//        pageController.delegate = self
//
//        addChild(pageController)
//        pageController.didMove(toParent: self)
//
//        pageController.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, direction: <#T##UIPageViewController.NavigationDirection#>, animated: <#T##Bool#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//
//    }

}
