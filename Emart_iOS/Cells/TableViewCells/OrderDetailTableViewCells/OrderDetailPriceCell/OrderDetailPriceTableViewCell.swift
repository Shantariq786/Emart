//
//  OrderDetailPriceTableViewCell.swift
//  Emart_iOS
//
//  Created by Asad Butt on 05/11/2021.
//

import UIKit

class OrderDetailPriceTableViewCell: UITableViewCell {

    static let cell_identifier = "OrderDetailPriceTableViewCell"
    
    @IBOutlet weak var deliveryAdress: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalSemiPriceLabel: UILabel!
    @IBOutlet weak var deliveryCharges: UILabel!
    @IBOutlet weak var noOfItems: UILabel!
    @IBOutlet weak var estimtedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
