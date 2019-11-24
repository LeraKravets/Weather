//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Лера on 9/30/19.
//  Copyright © 2019 com.vkravets. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak fileprivate var searchCityLable: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
