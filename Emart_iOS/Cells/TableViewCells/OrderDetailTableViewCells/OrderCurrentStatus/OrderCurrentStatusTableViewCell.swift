//
//  OrderCurrentStatusTableViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 17/11/2021.
//

import UIKit

//shop_state
class OrderCurrentStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var preperationVIew: UIView!
    @IBOutlet weak var pickUpView: UIView!
    
    
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var pendingTimeLabel: UILabel!
    
    @IBOutlet weak var preperationLabel: UILabel!
    @IBOutlet weak var preperationTimeLabel: UILabel!
    
    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    
    static let cell_identifier = "OrderCurrentStatusTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setCornerRadius()
    }

    func setCornerRadius(){
        pendingView.roundCorners(corners: [.topLeft,.bottomLeft], radius: 5)
        pickUpView.roundCorners(corners: [.topRight,.bottomRight], radius: 10)
    }
    
    func setData(status:Int){
        if status == 1{
            pendingView.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            preperationVIew.backgroundColor = UIColor(named: "AppLightGrayColor")
            pickUpView.backgroundColor = UIColor(named: "AppLightGrayColor")
            
            pendingLabel.textColor = UIColor.white
            pendingTimeLabel.textColor = UIColor.white
            preperationLabel.textColor = UIColor.black
            preperationTimeLabel.textColor = UIColor.black
            pickUpLabel.textColor = UIColor.black
            pickUpTimeLabel.textColor = UIColor.black
            
        }else if status == 2{
            pendingView.backgroundColor = UIColor(named: "AppLightGrayColor")
            preperationVIew.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            pickUpView.backgroundColor = UIColor(named: "AppLightGrayColor")
            
            pendingLabel.textColor = UIColor.black
            pendingTimeLabel.textColor = UIColor.black
            preperationLabel.textColor = UIColor.white
            preperationTimeLabel.textColor = UIColor.white
            pickUpLabel.textColor = UIColor.black
            pickUpTimeLabel.textColor = UIColor.black
            
        }else if status == 3{
            pendingView.backgroundColor = UIColor(named: "AppLightGrayColor")
            preperationVIew.backgroundColor = UIColor(named: "AppLightGrayColor")
            pickUpView.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            
            pendingLabel.textColor = UIColor.black
            pendingTimeLabel.textColor = UIColor.black
            preperationLabel.textColor = UIColor.black
            preperationTimeLabel.textColor = UIColor.black
            pickUpLabel.textColor = UIColor.white
            pickUpTimeLabel.textColor = UIColor.white
        }
    }
    
}
