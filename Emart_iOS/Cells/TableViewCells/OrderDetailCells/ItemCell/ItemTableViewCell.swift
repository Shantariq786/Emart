//
//  ItemTableViewCell.swift
//  EMart
//
//  Created by Yousaf Shafiq on 08/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let cell_identifier = "ItemTableViewCell"
    
    @IBOutlet weak var itemNameLabel:UILabel!
    @IBOutlet weak var itemQtyLabel:UILabel!
    @IBOutlet weak var itemPriceLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(){
        
    }
    
}

