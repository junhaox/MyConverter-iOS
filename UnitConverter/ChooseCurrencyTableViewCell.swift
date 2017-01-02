//
//  ChooseCurrencyTableViewCell.swift
//  UnitConverter
//
//  Created by Junhao Xie on 1/2/17.
//  Copyright © 2017 Junhao Xie. All rights reserved.
//

import UIKit

class ChooseCurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var chooseImage: UIImageView!
    @IBOutlet weak var chooseCurrencyName: UILabel!
    @IBOutlet weak var chooseCurrencyUnit: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
