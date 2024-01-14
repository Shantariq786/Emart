//
//  SideMenuTableTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 18/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class SideMenuTableTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var optionname: UILabel!
    @IBOutlet weak var optionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func setData(optionname:String,optionImg:UIImage){
        self.optionname.text = optionname
        self.optionImage.image = optionImg
        
    }

}
