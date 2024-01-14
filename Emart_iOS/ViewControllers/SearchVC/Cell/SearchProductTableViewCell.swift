//
//  SearchProductTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 6/5/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class SearchProductTableViewCell: UITableViewCell {
    
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
        mainView.layer.cornerRadius = mainView.frame.height/8
        cartItemImage.layer.cornerRadius = cartItemImage.frame.height/8
        cartItemImage.clipsToBounds = true
        //    mainView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(record:SearchProductRecords){
        discription.text = record.product_description
        name.text = record.name
        price.text = record.price
        if let image = record.images{
            if let url = URL(string: "https://emart.pkgadget.com/images/\(image)"){
                cartItemImage.load(url: url)
            }
        }
    }
}
