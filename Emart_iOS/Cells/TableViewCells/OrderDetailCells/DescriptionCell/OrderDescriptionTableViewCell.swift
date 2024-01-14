//
//  OrderDescriptionTableViewCell.swift
//  EMart
//
//  Created by Apple on 12/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class OrderDescriptionTableViewCell: UITableViewCell {

    static let cell_identifier = "OrderDescriptionTableViewCell"
    
    @IBOutlet weak var descriptionNoLabel: UILabel!
    @IBOutlet weak var descriptionPriceLabel: UILabel!
    @IBOutlet weak var descriptionAddressLabel: UILabel!
    @IBOutlet weak var descriptionStreetAddressLabel: UILabel!
    @IBOutlet weak var descriptionItemsCountLabel: UILabel!
    @IBOutlet weak var descriptionCancelLabel: UILabel!
    @IBOutlet weak var descriptionNoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
