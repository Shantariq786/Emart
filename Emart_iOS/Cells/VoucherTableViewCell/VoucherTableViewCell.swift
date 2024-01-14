//
//  VoucherTableViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 10/02/2022.
//

import UIKit
protocol VoucherProtocol{
    func redeemBtnTapped(indexpath:IndexPath)
}
class VoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var voucherView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountCode: UILabel!
    @IBOutlet weak var expireyDate: UILabel!
    var indexpath:IndexPath!
    var voucherProtocol:VoucherProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        voucherView.layoutSubviews()
        dataView.layoutSubviews()
        voucherView.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
        dataView.roundCorners(corners: [.topRight,.bottomRight], radius: 10)
    }

    @IBAction func redeemBtnTapped(_ sender: Any) {
        voucherProtocol.redeemBtnTapped(indexpath: indexpath)
    }
    
    func setData(indexpath:IndexPath,record:VoucherRecord?){
        self.indexpath = indexpath
        
        discountLabel.text = "\(record?.percentage_off ?? "")%"
        discountCode.text = record?.coupon_key
        expireyDate.text = record?.expiry_date
    }
    
}
