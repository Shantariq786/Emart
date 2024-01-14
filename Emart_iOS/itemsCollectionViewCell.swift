//
//  itemsCollectionViewCell.swift
//  oye baryani
//
//  Created by Apple on 06/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class itemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemtotalprice: UILabel!
    @IBOutlet weak var itemqty: UILabel!
    @IBOutlet weak var itemprice: UILabel!
    @IBOutlet weak var itemname: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override  func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.height/8
               imageView.clipsToBounds = true
    }
}
