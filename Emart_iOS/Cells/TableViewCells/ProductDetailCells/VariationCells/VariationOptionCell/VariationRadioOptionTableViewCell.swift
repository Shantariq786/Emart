//
//  VariationOptionTableViewCell.swift
//  EMart
//
//  Created by Muhammad Yousaf on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class VariationRadioOptionTableViewCell: UITableViewCell {
    
    static let cell_identifier = "VariationRadioOptionTableViewCell"
    
    
    @IBOutlet weak var variationNameLabel:UILabel!
    @IBOutlet weak var variationPriceLabel:UILabel!
    
    @IBOutlet weak var radioImage:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
