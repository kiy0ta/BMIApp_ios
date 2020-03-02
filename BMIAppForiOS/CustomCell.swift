//
//  CustomCell.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/04.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CustomCell:UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    
    }
}
