//
//  WCWeatherCell.swift
//  WeatherCast
//
//  Created by RAHUL CK on 4/8/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class WCWeatherCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(city:String,temperature:String) {
        self.titleLabel.text = city
        self.temperatureLabel.text = "\(temperature)° C"
    }

}
