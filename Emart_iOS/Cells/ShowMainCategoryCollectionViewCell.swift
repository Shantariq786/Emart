//
//  ShowMainCategoryCollectionViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class ShowMainCategoryCollectionViewCell: UICollectionViewCell {
     
    @IBOutlet weak var mainCategoryImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        mainCategoryImage.layer.cornerRadius = mainCategoryImage.frame.height / 2
        mainCategoryImage.clipsToBounds = true
    }
    
    func setupData(records:showMainCategoryRecords?){
        if let image = records?.image_name {
            if let url = URL(string: "\(BASEURL.imageUrl)\(image)"){
                mainCategoryImage.load(url: url)
            }
            nameLbl.text = records?.name ?? ""
        }
    }
}
