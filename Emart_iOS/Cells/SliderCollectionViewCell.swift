//
//  SliderCollectionViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var sliderImageview: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderImageview.layer.cornerRadius = 8.0;
        sliderImageview.contentMode = UIView.ContentMode.scaleAspectFill
        sliderImageview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        sliderImageview.layer.shadowOpacity = 0.4
    }

    func setupData(record:showSliderRecords?) {
        if let url = URL(string: "\(BASEURL.imageUrl)\(record?.image ?? "")"){
            sliderImageview.load(url: url)
        }
    }
}
