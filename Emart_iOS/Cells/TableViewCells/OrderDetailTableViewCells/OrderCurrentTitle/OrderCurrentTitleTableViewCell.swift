//
//  OrderCurrentTitleTableViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 17/11/2021.
//

import UIKit
import Lottie

class OrderCurrentTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ordeStatusTitle: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    static let cell_identifier = "OrderCurrentTitleTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(status:String){
        let statusNumber = Int(status) ?? 0
        if statusNumber == 1 || statusNumber == 3{
            loadAnimation(animationName: "pending_state", animatedView: animationView)
        }else if statusNumber == 2{
            loadAnimation(animationName: "shop_state", animatedView: animationView)
        }else if statusNumber == 4 || statusNumber == 5 || statusNumber == 6 || statusNumber == 8 {
            loadAnimation(animationName: "delete_state", animatedView: animationView)
        }else if statusNumber == 7{
            loadAnimation(animationName: "success_state", animatedView: animationView)
        }
    }
    
    func loadAnimation(animationName:String,animatedView:AnimationView){
        if let animation = Animation.named(animationName){
            animatedView.animation = animation
            animatedView.loopMode = .loop
            animatedView.animationSpeed = 1
            animatedView.play()
        }
    }
    
    

    
}
