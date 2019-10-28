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
    @IBOutlet weak var backgroundView: UIImageView!

    @IBOutlet weak var dailyWeatherTableView: UITableView!

//    @IBOutlet weak var citiesPageControl: UIPageControl!


    var city: City?
    var setOfDailyWeather: Set<DailyWeather>?
    var arrayOfDailyWeather: [DailyWeather]?

    let cellId = "DailyWeatherCellID"
//    var currentWeather: CurrentWeather?
//    var dailyWeather: DailyWeather?

    override func viewDidLoad() {
        super.viewDidLoad()
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self

        cityLabel.text = city?.cityName
        summaryLabel.text = city?.currentWeather?.summary
        guard let currentTemp = city?.currentWeather?.currentTemp else { return }
        tempLabel.text = String(Int(currentTemp))

//        let setOfDailyWeather = city?.dailyWeathert as? Set<DailyWeather> ?? []
        setOfDailyWeather = city?.dailyWeathert as? Set<DailyWeather>
        arrayOfDailyWeather = setOfDailyWeather?.sorted(by: { $0.date < $1.date })


       



//        for oneDayWeather in setOfDailyWeather {
//            let dailyTemp = oneDayWeather.dailyTemp
//            let dailyIcon = oneDayWeather.dailyIcon
//            let tempMax = oneDayWeather.tempMax
//            let tempMin = oneDayWeather.tempMin
//            let date = oneDayWeather.date
//
//            print(oneDayWeather)
//        }
    }

    @IBAction func backToMenuButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension CityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

}
extension CityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setOfDailyWeather?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DailyWeatherTableViewCell else {
            fatalError("Can't find cell with id: \(cellId)")
        }
        if let arrayOfDailyWeather = arrayOfDailyWeather {
            cell.updateDailyWeather(dailyWeatherInfo: arrayOfDailyWeather[indexPath.row])
        }

        return cell
    }
    

}
