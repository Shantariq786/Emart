//
//  ShowCartItemTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 20/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ShowCartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //itemImageView.clipsToBounds = true
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      

        
    }
    func setData(records:CardsRecord){
        if let itemprice = Int(records.price ?? "0") ,let itemquantity = Int(records.quantity ?? "1")
        {
            itemPrice.text = "Rs \( itemprice * itemquantity)"
            itemName.text = records.name
            itemQuantity.text = "\(records.quantity ?? "") x"
        }
    }

}
