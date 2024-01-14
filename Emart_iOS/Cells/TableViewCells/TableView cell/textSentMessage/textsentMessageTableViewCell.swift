//
//  textsentMessageTableViewCell.swift
//  CustomChat
//
//  Created by Asad Butt on 02/11/2021.
//

import UIKit

class textsentMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var sentTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        roundedView.layer.cornerRadius = 8
    }

    
    
}
