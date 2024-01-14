//
//  ImageReceiveMessageTableViewCell.swift
//  CustomChat
//
//  Created by Asad Butt on 02/11/2021.

import UIKit

class ImageReceiveMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var receiveImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.layer.cornerRadius = 8
    }
    //give wait for a sec

    func setImage(stringUrl:String){
        let fullSrtUrl = "\(BASEURL.imageUrl)\(stringUrl)"
        print("fullSrtUrl \(fullSrtUrl)")
        let url = URL(string: fullSrtUrl)
        receiveImage.kf.setImage(with: url)
        
        
    }
    
}
