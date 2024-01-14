//
//  RatingCellTableViewCell.swift
//  Emart_iOS
//
//  Created by Hexacrew on 10/02/2022.
//

import UIKit
import Cosmos

class RatingCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var postedTimeLabel: UILabel!
    @IBOutlet weak var reviewLabell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    func setdata(record:RatingRecord?){
        let rating = Double(record?.rating ?? "0")
        ratingLabel.text = "\(rating ?? 0.0)"
        ratingView.rating = rating ?? 0.0
        reviewLabell.text = record?.comment
    }

    
}
