//
//  textReceriveMessageTableViewCell.swift
//  CustomChat
//
//  Created by Asad Butt on 02/11/2021.
//

import UIKit

class textReceriveMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var receiveTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        roundedView.layer.cornerRadius = 8
    }
    
}
