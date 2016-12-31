//
//  CurrencyTableViewCell.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/29/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var currencyUnit: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
