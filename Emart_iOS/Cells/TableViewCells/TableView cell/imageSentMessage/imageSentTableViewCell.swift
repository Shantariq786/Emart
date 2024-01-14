//
//  imageSentTableViewCell.swift
//  CustomChat
//
//  Created by Asad Butt on 02/11/2021.
//

import UIKit
import Kingfisher

class imageSentTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var sentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedView.layer.cornerRadius = 8
    }

    func setImage(stringUrl:String){
        let fullSrtUrl = "\(BASEURL.imageUrl)\(stringUrl)"
        print("fullSrtUrl \(fullSrtUrl)")
        let url = URL(string: fullSrtUrl)
        sentImage.kf.setImage(with: url)
        
        
    }
    
}
