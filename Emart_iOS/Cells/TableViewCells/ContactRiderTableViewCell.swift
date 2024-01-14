//
//  ContactRiderTableViewCell.swift
//  EMart
//
//  Created by Asad Butt on 04/11/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Kingfisher

protocol ChatButtonTappedProtocol {
    func moveToChat()
}

class ContactRiderTableViewCell: UITableViewCell {

    static let cell_identifier = "ContactRiderTableViewCell"
    var chatButtonTappedProtocol:ChatButtonTappedProtocol!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var contactButton:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
    }
    func setData(rider:orderRider){
        nameLabel.text = rider.name
        
        let fullSrtUrl = "\(BASEURL.imageUrl)\(rider.image ?? "")"
        print("fullSrtUrl \(fullSrtUrl)")
        let url = URL(string: fullSrtUrl)
        profileImageView.kf.setImage(with: url)
    }

    @IBAction func contactRider(_ sender: UIButton) {
        chatButtonTappedProtocol.moveToChat()
    }
    
    
}
