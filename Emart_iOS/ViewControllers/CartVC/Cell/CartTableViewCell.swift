//
//  CartTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 22/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var stipperview: UIView!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subtract: UIButton!
    @IBOutlet weak var cartItemImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        mainView.layer.cornerRadius = mainView.frame.height/8
//        cartItemImage.layer.cornerRadius = cartItemImage.frame.height/8
        cartItemImage.clipsToBounds = true
        //    mainView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(record:CardsRecord){
        if let itemprice = record.price ,let itemquantity = record.quantity {
            let intprice = Int(itemprice)
            let intquantity = Int(itemquantity)
            price.text = "\( intprice! * intquantity!)"
            name.text = record.name
            counter.text = record.quantity
            if let image = record.images?.first?.image{
                
                cartItemImage.sd_setImage(with: URL(string: BASEURL.imageUrl+image), placeholderImage: UIImage(named: "placeholder.png"))
            }
            
        }
        
    }
    
    
    
    func setProduct(record:RestaurantProduct){
        discription.text = getAllVariations(record: record)
        if let itemprice = record.price ,let itemquantity = record.quantity {
            price.text = String(getPrice(record: record))
            name.text = record.name
            counter.text = record.quantity
            if let image = record.images?.first?.image{
                
                cartItemImage.sd_setImage(with: URL(string: BASEURL.imageUrl+image), placeholderImage: UIImage(named: "placeholder.png"))
            }
            
        }
        
    }
    
    func getAllVariations(record:RestaurantProduct)->String{
        var variationsNames = ""
        if record.variationGroups?.count == 0{
            // product which have no variation
            return variationsNames
            
        }else{
            for variation in record.variationGroups!{
                for vari in variation.variations! {
                    if vari.isChecked!{
                        variationsNames = "\(variationsNames + vari.name!),"
                    }
                }
                
        }
            
            return variationsNames
    }
}
    
    func getPrice(record:RestaurantProduct)->Int{
        var totalPrice = Int(record.price!)
        if record.variationGroups?.count == 0{
            // product which have no variation
            return totalPrice! * Int(record.quantity!)!
            
        }
        else{
            for variation in record.variationGroups!{
                for vari in variation.variations! {
                    if vari.isChecked!{
                        totalPrice = totalPrice! + Int(vari.price!)!
                    }
                }
               
                
            }
            return totalPrice! * Int(record.quantity!)!
        }
        
    }
}
