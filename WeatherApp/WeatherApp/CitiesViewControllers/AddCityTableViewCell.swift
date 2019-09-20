//
//  AddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 9/17/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class AddCityTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var addCityLabel: UIButton!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Actions

    @IBAction func addCityButton(_ sender: Any) {
    }
}
