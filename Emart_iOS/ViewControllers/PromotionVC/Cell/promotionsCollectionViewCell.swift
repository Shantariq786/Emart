//
//  promotionsCollectionViewCell.swift
//  Alamofire
//
//  Created by Apple on 31/01/2020.
//

import UIKit
import Kingfisher

class promotionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagess: UIImageView!
    
    func setImage(sliderImage:SliderImages){
        let fullSrtUrl = "\(BASEURL.imageUrl)\(sliderImage.image!)"
        let url = URL(string: fullSrtUrl)!
        
        imagess.kf.setImage(with: url)
    }
   
}
