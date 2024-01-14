//
//  SubCatColllectionViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 07/01/2022.
//

import UIKit

class SubCatColllectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(title:String){
        titleLabel.text = title
    }

}
