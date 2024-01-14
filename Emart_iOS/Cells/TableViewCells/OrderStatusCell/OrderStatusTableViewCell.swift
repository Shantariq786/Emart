//
//  OrderStatusTableViewCell.swift
//  Emart_iOS
//
//  Created by Asad Butt on 05/11/2021.
//

import UIKit

class OrderStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var statusNumber: UILabel!
    @IBOutlet weak var statusValue: UILabel!
    
    static let cell_identifier = "OrderStatusTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        roundedView.layer.cornerRadius = roundedView.frame.size.width/2
        roundedView.clipsToBounds = true
    }

    
}
