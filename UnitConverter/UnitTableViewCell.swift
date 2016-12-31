//
//  UnitTableViewCell.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/29/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit

class UnitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
