//
//  DropDownCellItem.swift
//  Emart_iOS
//
//  Created by Hexacrew on 22/11/2021.
//

import UIKit
import DropDown

class DropDownCellItem: DropDownCell {

    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
