//
//  HeaderHomeView.swift
//  EMart
//
//  Created by Muhammad Yousaf on 05/07/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
protocol HeaderViewProtocol{
    func viewAllBtnTapped(section:Int)
}

class HeaderHomeView: UIView {
    var headerViewProtocol:HeaderViewProtocol!
    @IBOutlet weak var headerLabel:UILabel!
    @IBOutlet weak var viewAllButton:UIButton!
    var section:Int!
    @IBAction func viewAllTapped(_ sender:UIButton){
        headerViewProtocol.viewAllBtnTapped(section: section)
    }
    



}
