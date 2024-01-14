//
//  sideorderCollectionViewCell.swift
//  oye baryani
//
//  Created by Apple on 31/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class sideorderCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var price: UILabel!
    
      @IBOutlet weak var imageview: UIImageView!

      @IBOutlet weak var discription: UILabel!
      @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
         super.awakeFromNib()
               mainView.layer.cornerRadius = mainView.frame.height/9
                mainView.clipsToBounds = true
    }
  
}
