//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 9/17/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Variables

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Life Cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Actions

}
