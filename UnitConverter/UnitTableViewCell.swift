//
//  UnitTableViewCell.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/29/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit

class UnitTableViewCell: UITableViewCell {
<<<<<<< HEAD
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
=======

    @IBOutlet weak var unitName: UILabel!
    @IBOutlet weak var unitNum: UILabel!
    @IBOutlet weak var unitText: UILabel!
>>>>>>> parent of 0a4c596... fixed
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
