//
//  VariationCheckBoxOptionTableViewCell.swift
//  EMart
//
//  Created by Apple on 05/10/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol CheckBoxOptionDelegete{
    
    func CheckBoxTapped(_ variation:Variations , _ currentState:Bool)
    
}

class VariationCheckBoxOptionTableViewCell: UITableViewCell {
    
    var checkBoxOptionDelegete: CheckBoxOptionDelegete?
    var variaitons:Variations?
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var variationNameLabel:UILabel!
    @IBOutlet weak var variationPriceLabel:UILabel!
    
    static let cell_identifier = "VariationCheckBoxOptionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBox.delegate = self
    }
    
    func setData(data:Variations){
        variationNameLabel.text = data.name
        variationPriceLabel.text = "+ \(data.price ?? "0")"
    }
    
}

extension VariationCheckBoxOptionTableViewCell: BEMCheckBoxDelegate{
    
    func didTap(_ checkBox: BEMCheckBox) {
        print(variaitons)
        checkBoxOptionDelegete?.CheckBoxTapped(variaitons!, checkBox.on)
    }
}
