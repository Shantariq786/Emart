//
//  ShopDetailCollectionviewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 06/01/2022.
//

import UIKit

class ShopDetailCollectionviewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setData(title:String){
        titleLabel.text = title
    }

}
