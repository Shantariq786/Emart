//
//  ProductDetailViewController.swift
//  EMart
//
//  Created by Muhammad Yousaf on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

var selectedVariations = [String]()
class ProductDetailViewController: UIViewController {
    
    
    var selectedVariation : Variations?
    var selectedVariationIndex = 0
    var restaurantProduct:RestaurantProduct?
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    var isCart = false
    var previousQuantity = 1
    var currentQuantity = 1
    
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var productImage:UIImageView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!//CustomButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedVariations.removeAll()
        if let quantity = Int(restaurantProduct!.quantity!){
            if quantity == 0 {
                previousQuantity = 1
            }else{
                previousQuantity = quantity
            }
        }
       
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: VariationRadioOptionTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: VariationRadioOptionTableViewCell.cell_identifier)
        tableView.register(UINib(nibName: ProductDetailTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: ProductDetailTableViewCell.cell_identifier)
        
        if let image = restaurantProduct?.images?.first?.image{
            let imageUrl = BASEURL.imageUrl+image
            print("\(imageUrl)")
            productImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        productNameLabel.text = restaurantProduct?.name
        productPriceLabel.text = "Rs \(restaurantProduct?.price ?? "0")"
        productDescriptionLabel.text = restaurantProduct?.productDescription
        
        totalPriceLabel.text = "Rs \(restaurantProduct?.price ?? "0")"
        if let quantity = restaurantProduct?.quantity{
            if quantity == "0"{
                quantityLabel.text = "1"
            }else{
                quantityLabel.text = restaurantProduct?.quantity
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePrice), name: Notification.Name("updatePrice"), object: nil)
        
        
        productNameView.roundCorner([.topLeft,.topRight], radius: 30.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.layoutSubviews()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        var rowCounts = 0
        for groups in restaurantProduct!.variationGroups!{
            for variations in groups.variations!{
                rowCounts += 1
            }
            
            print("rowCounts: \(rowCounts)")
            contentViewHeight.constant = CGFloat(rowCounts * 40) + 500
            
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    @objc func updatePrice(notification: Notification) {
        print("price notification call")
        if let price = notification.object as? String,
           let action = notification.userInfo?.values.first as? String{
            if action == "minus"{
                if let totalPrice = totalPriceLabel.text?.components(separatedBy: " ")[1]{
                    let total_price = Int(totalPrice)
                    let minus_price = Int(price)
                    totalPriceLabel.text = "Rs \(total_price! - minus_price!)"
                }
            }else if action == "add"{
                if let totalPrice = totalPriceLabel.text?.components(separatedBy: " ")[1]{
                    let total_price = Int(totalPrice)
                    let add_price = Int(price)
                    totalPriceLabel.text = "Rs \(total_price! + add_price!)"
                }
            }
            
        }
        print(notification.object)
        print(notification.userInfo)
        //Write you code
    }
    
    @IBAction func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addQuantityAction(_ sender: Any) {
        currentQuantity = currentQuantity+1
        if let totalPrice = totalPriceLabel.text?.components(separatedBy: " ")[1],
           let totalQuantity = quantityLabel.text{
            
            if let total_price = Int(totalPrice),
               let total_quantity = Int(totalQuantity){
                
                let perItemPrice = total_price / total_quantity
                quantityLabel.text = "\(total_quantity + 1)"
                totalPriceLabel.text = "Rs \(total_price + perItemPrice)"
            }
            
            
        }
        
        
    }
    @IBAction func minusQuantityAction(_ sender: Any) {
        currentQuantity = currentQuantity - 1
        if let totalPrice = totalPriceLabel.text?.components(separatedBy: " ")[1],
           let totalQuantity = quantityLabel.text{
            if let total_price = Int(totalPrice),
               let total_quantity = Int(totalQuantity){
                
                if total_quantity > 1{
                    let perItemPrice = total_price / total_quantity
                    quantityLabel.text = "\(total_quantity - 1)"
                    totalPriceLabel.text = "Rs \(total_price - perItemPrice)"
                }
            }
        }
        
    }
    
    var variationsIds = ""
   
    @IBAction func addToCart(){
        print("previousQuantity \(previousQuantity) currentQuantity \(currentQuantity)")
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            if let product = self.restaurantProduct{
                        guard let productId = product.id
                        else {
                            return
                        }
                if selectedVariations.count > 0{
                    for id in selectedVariations{
                        if variationsIds == ""{
                            variationsIds = id
                        }else{
                            variationsIds = variationsIds + ",\(id)"
                        }
                        print("variationsIds: \(variationsIds)")
                    }
                    // update the quantity of the product
                    
                    addToCart(email: user.email!, product_id: productId, variations: variationsIds)
                    
                }
            }
    }
    
    func updateCartItemQuantity(id: String, user_email: String, quantity: String){
        let parameter = ["id": id,
                         "user_email": user_email,
                         "quantity": quantity]
        
        
        APIService.sharedInstance.updateCart(parameters: parameter) { (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
//                self.navigationController?.popViewController(animated: true)
//                self.getProducts(categoryId: (self.resturantProducts?.records?[self.cartSelectedIndex].id)!)
            }
            print(AddToCart.errorMsg)
            
        }
        failure: { (error) -> (Void) in
            print(error)
        }
    }
    func removetoCart(product_id:String,completion:@escaping ((Bool)->Void)) {
        guard let productid = Int(product_id), let user = UserStateHolder.loggedInUser else{
            return
        }
        let parameter:[String:Any] = ["email":user.email ?? "","product_id": productid]
        let urlstring = URLPath.RemovetoCart
        guard let url = URL(string: urlstring) else {
            print("URL Error")
            return
        }
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Loading")
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parameter) { (errorMessage, error) in
            SVProgressHUD.dismiss()
            if error == false{
                completion(true)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                completion(false);
                UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
        }
    }
    func addToCart(email: String, product_id: String, variations: String){
        print("email \(email) product_id \(product_id) variations \(variations)")
        let parameter = ["email": email,
                         "product_id": product_id,
                         "variations": variations] as [String : Any]
        
        APIService.sharedInstance.addToCart(parameters: parameter) { [self] (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
                if(previousQuantity != currentQuantity){
                    print("come in update quantatiy api")
                    updateCartItemQuantity(id: product_id, user_email: email, quantity: String(currentQuantity))
                }
                self.navigationController?.popViewController(animated: true)
            }
            print(AddToCart.errorMsg)
            
        }
        failure: { (error) -> (Void) in
            print(error)
        }
    }
}


extension ProductDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let product = self.restaurantProduct{
            if let variationsGroup = product.variationGroups{
                print("variationsGroup \(variationsGroup)")
                return variationsGroup.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let product = self.restaurantProduct{
            if let variationsGroup = product.variationGroups?[indexPath.row].variations{
                //            if let variation = variationsGroup.variations{
                
                // variation group represent each section
                
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.cell_identifier, for: indexPath) as! ProductDetailTableViewCell
                
                let requiredStatus = product.variationGroups?[indexPath.row].required
                if requiredStatus == "1"{
                    cell.productStatusLabel.text = "Required"
                    cell.isRequired = true
                }else{
                    cell.productStatusLabel.text = "Optional"
                    cell.isRequired = false
                }
                
                cell.productNameLabel.text = product.variationGroups?[indexPath.row].title
                cell.variationsData = variationsGroup
                cell.tableviewHeight.constant = CGFloat(variationsGroup.count * 40)
                cell.layoutIfNeeded()
                
                
                cell.variationsTableView.reloadData()
                self.tableView.beginUpdates() //Parent TableView
                self.tableView.endUpdates() // Parent TableView
                
                
                
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("first tableview")
//        if let product = self.restaurantProduct{
//            if let variationsGroup = product.variationGroups?.first{
//                if let variation = variationsGroup.variations{
//                    if indexPath.row < variation.count {
//                        self.selectedVariationIndex = indexPath.row
//                        self.tableView.reloadData()
//
//                    }
//                }
//            }
//        }
    }
    
}
