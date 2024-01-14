//
//  ProductDetailTableViewCell.swift
//  EMart
//
//  Created by Muhammad Yousaf on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    
    
    
    static let cell_identifier = "ProductDetailTableViewCell"
    
    var restaurantProduct:RestaurantProduct?
    @IBOutlet weak var variationsTableView: UITableView!
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var productNameLabel:UILabel!
    @IBOutlet weak var productStatusLabel:UILabel!

    var variationsData = [Variations]()
    var isRequired = false
    var selectedRadioVariationIndex = 0
    var radioOldIndex = 0
    var radioIndexCount = 0
    
    
    var selectedCheckVariationIndex = -1
    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        self.variationsTableView.layoutSubviews()
        variationsTableView.delegate = self
        variationsTableView.dataSource = self
        variationsTableView.estimatedRowHeight = 68.0
        variationsTableView.rowHeight = UITableView.automaticDimension
        variationsTableView.register(UINib(nibName: VariationRadioOptionTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: VariationRadioOptionTableViewCell.cell_identifier)
        
        variationsTableView.register(UINib(nibName: VariationCheckBoxOptionTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: VariationCheckBoxOptionTableViewCell.cell_identifier)
        
        variationsTableView.reloadData()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    func setUpData(){
//        if let product = self.restaurantProduct{
//            self.productNameLabel.text = product.name
//            self.productDescLabel.text = product.productDescription
//            self.productAboutLabel.text = product.productDescription
//            if let discountPrice = product.discountPrice{
//                if discountPrice == "" || discountPrice == "0"{
//                    self.productDiscountedLabel.text = ""
//                    self.productPriceLabel.text = "RS \(product.price ?? "0")"
//                }else{
//                    self.productDiscountedLabel.text = "RS \(product.discountPrice ?? "0")"
//                    self.productPriceLabel.attributedText = "RS \(product.price ?? "0")".strikeThrough()
//                }
//            }else{
//                //this mean it is nil
//                self.productDiscountedLabel.text = ""
//                self.productPriceLabel.text = "RS \(product.price ?? "0")"
//            }
//            self.productStatusLabel.text = "Available"
//        }
//    }
    
}

extension ProductDetailTableViewCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("variationsData \(variationsData)")
        return variationsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isRequired{
            let cell = tableView.dequeueReusableCell(withIdentifier: VariationRadioOptionTableViewCell.cell_identifier, for: indexPath) as! VariationRadioOptionTableViewCell
            let data = variationsData[indexPath.row]
            
            if selectedRadioVariationIndex == indexPath.row{
                
                if(radioOldIndex == selectedRadioVariationIndex && radioIndexCount>0){
                    print("Just do nothing")
                }else{
                    selectedVariations.append(data.id!)
                    cell.radioImage.image =  UIImage(named: "ic_radio_selected")
                    print("selectedVariations: \(selectedVariations)")
                    NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: data.price, userInfo: ["key":"add"])
                    
                    radioOldIndex = selectedRadioVariationIndex
                    radioIndexCount = radioIndexCount + 1
                }
            }
            else{
                if selectedVariations.contains(data.id!){
                    let index = selectedVariations.firstIndex(of: data.id!)
                    selectedVariations.remove(at: index!)
                    print("selectedVariations: \(selectedVariations)")
                    NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: data.price, userInfo: ["key":"minus"])
                }
                
                cell.radioImage.image = UIImage(named: "ic_radio_unselected")
            }
            cell.variationNameLabel.text = data.name
            cell.variationPriceLabel.text = "+ \(data.price ?? "0")"

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: VariationCheckBoxOptionTableViewCell.cell_identifier, for: indexPath) as! VariationCheckBoxOptionTableViewCell
            
            let data = variationsData[indexPath.row]
            cell.checkBoxOptionDelegete = self
            cell.checkBox.boxType = .square
            cell.checkBox.on = false
            cell.variaitons = data
            cell.setData(data: data)


            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = variationsData[indexPath.row]
        if (tableView.cellForRow(at: indexPath) as? VariationRadioOptionTableViewCell) != nil {
            print("cell is tapped")
            selectedRadioVariationIndex = indexPath.row
            variationsTableView.reloadData()
        }
        if let cell1 = tableView.cellForRow(at: indexPath) as? VariationCheckBoxOptionTableViewCell {
            cell1.checkBoxOptionDelegete = self
            if cell1.checkBox.on{
                print("come in checkbox on")
                cell1.checkBox.on = false
                if selectedVariations.contains(data.id!){
                    let index = selectedVariations.firstIndex(of: data.id!)
                    selectedVariations.remove(at: index!)
                    print("selectedVariations-----: \(selectedVariations)")
                    NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: data.price, userInfo: ["key":"minus"])
                }
            }
            else{
                print("come in else")
                cell1.checkBox.on = true
                selectedVariations.append(data.id!)
                print("selectedVariations: \(selectedVariations)")
                NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: data.price, userInfo: ["key":"add"])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
//and to call the function is the same
//
//yourLabel.attributedText = "yourString".strikeThrough()

extension ProductDetailTableViewCell:CheckBoxOptionDelegete{
    

    
    func CheckBoxTapped(_ variation: Variations,_ currentState:Bool) {
        print("tapped")
        print(currentState)
        if currentState == false{
            if selectedVariations.contains(variation.id!){
                let index = selectedVariations.firstIndex(of: variation.id!)
                selectedVariations.remove(at: index!)
                print("selectedVariations-----: \(selectedVariations)")
                NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: variation.price, userInfo: ["key":"minus"])
            }
        }
        else{
            selectedVariations.append(variation.id!)
            print("selectedVariations: \(selectedVariations)")
            NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: variation.price, userInfo: ["key":"add"])
        }
        
    }
    
}
