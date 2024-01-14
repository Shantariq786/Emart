//
//  UserAddressesTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 23/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class UserAddressesTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var removeAddressesButton: UIButton!
    @IBOutlet weak var userCurrentLocation: UILabel!
    @IBOutlet weak var userAddressesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = mainView.frame.height/6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func SetData(record:AddressRecords)
    {
        userCurrentLocation.text = record.gps_address
        userAddressesLabel.text = record.address
        
        
        
    }

}
