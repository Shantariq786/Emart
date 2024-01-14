//
//  ResturntProductCollectionViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 07/01/2022.
//

import UIKit
import Kingfisher

protocol ResturantProductProtocol{
    func addToCart(indexPath:IndexPath)
    func addItemToCart(indexPath:IndexPath)
    func popItemFromCart(indexPath:IndexPath)
}


class ResturntProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var counterView: CardView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var resturantProductProtocol:ResturantProductProtocol!
    var indexPath:IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:RestaurantProduct, indexPath:IndexPath){
        
        guard let imageStringURl = data.images?[0].image else {return}
        let fullSrtUrl = "\(BASEURL.imageUrl)\(imageStringURl)"
        print("fullSrtUrl \(fullSrtUrl)")
       
        
        
        self.indexPath = indexPath
        itemNameLabel.text = data.name
        itemPriceLabel.text = data.price
        
        if(data.variationGroups?.count == 0){
            //show add to cart button
            
            if data.quantity == "0"{
                addToCartButton.isHidden = false
                counterView.isHidden = true
            }else{
                addToCartButton.isHidden = true
                counterView.isHidden = false
                quantityLabel.text = data.quantity
            }
            
        }
        else{
            // do not show cart button
            
            if data.quantity == "0"{
                addToCartButton.isHidden = true
                counterView.isHidden = true
            }else{
                addToCartButton.isHidden = true
                counterView.isHidden = false
                quantityLabel.text = data.quantity
            }
        }
        
        itemImageView.image = UIImage(named: "delivero_logo")
        guard let url = URL(string: fullSrtUrl) else {return}
        itemImageView.kf.setImage(with: url)
    }
    
    @IBAction func addToCartBtnTapped(_ sender: UIButton) {
        resturantProductProtocol.addToCart(indexPath:indexPath)
    }
    
    @IBAction func minusBtnTapped(_ sender: UIButton) {
        resturantProductProtocol.popItemFromCart(indexPath:indexPath)
    }
    
    @IBAction func plusBtnTapped(_ sender: UIButton) {
        resturantProductProtocol.addItemToCart(indexPath:indexPath)
    }
}
