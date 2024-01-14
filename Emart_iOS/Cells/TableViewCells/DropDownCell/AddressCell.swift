//
//  AddressCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 06/12/2021.
//

import UIKit
import DropDown

class AddressCell: DropDownCell {

    @IBOutlet weak var addressImage: UIImageView!
    @IBOutlet weak var addressTitile: UILabel!
    @IBOutlet weak var addressDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
