//
//  OrderCurrentVenderDetailsTableViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 17/11/2021.
//

import UIKit
protocol OrderCurrentVenderProtocol{
    func addReviewTapped(indexPath:IndexPath)
    func cancelOrderTapped(indexPath:IndexPath)
}

class OrderCurrentVenderDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteOrderbtn: UIButton!
    @IBOutlet weak var venderName: UILabel!
    @IBOutlet weak var orderId: UILabel!
    static let cell_identifier = "OrderCurrentVenderDetailsTableViewCell"
    var status = 0
    
    var indexPath:IndexPath!
    var orderCurrentVenderProtocol:OrderCurrentVenderProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        orderCurrentVenderProtocol.cancelOrderTapped(indexPath: indexPath)
    }
    
    @IBAction func addReviewBtn(_ sender: Any) {
        orderCurrentVenderProtocol.addReviewTapped(indexPath: indexPath)
    }
    
    func setData(venderName:String,orderId:String,status:Int){
        self.venderName.text = venderName
        self.orderId.text = orderId
        
        if status == 3 || status == 4 || status == 5 || status == 6 || status == 7{
            deleteOrderbtn.isHidden = true
        }
        
    }
    
    
}
