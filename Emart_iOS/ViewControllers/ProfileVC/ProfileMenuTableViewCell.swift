//
//  ProfileMenuTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 6/20/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class ProfileMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
