//
//  NotificationsTableViewCell.swift
//  EMart
//
//  Created by Apple on 05/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit


class NotificationsTableViewCell: UITableViewCell {

    static let cell_identifier = "NotificationsTableViewCell"
    
    @IBOutlet weak var orderMessageLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cardView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(notification:NotificationsRecord){
        orderNumberLabel.text = notification.order_id
        orderMessageLabel.text = notification.message
        dateLabel.text = notification.timestamp
        if Int(notification.isread!) == 0{
            cardView.backgroundColor =  UIColor(displayP3Red: 242/255, green: 240/255, blue: 253/255, alpha: 1)
        }else{
            cardView.backgroundColor = UIColor.white
        }
    }
    
}
