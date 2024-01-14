//
//  ResturantDetailViewController.swift
//  EMart
//
//  Created by Apple on 28/07/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import Kingfisher

protocol ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath:IndexPath,resturantData : showRestaurantsRecords)
}

class ResturantItemsCell: UITableViewCell{
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var counterView: CardView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
}
//

class ResturantFoodCategoryCell: UICollectionViewCell{
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
}




class ResturantDetailViewController: UIViewController {

    
    @IBOutlet weak var bgImage:UIImageView!
    @IBOutlet weak var favourtieBackView:UIView!
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var resturantImageView: RoundImage!
    @IBOutlet weak var resturantNameLabel: UILabel!
    @IBOutlet weak var resturantDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var resturantFavouriteButton: UIButton!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalCartCount: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    
    
    var resturantCategory : ResturantFoodCategoryResult? = nil
    var favouriteResult : GenericModel? = nil
    
    
    var resturantProducts : RestaurantProductResult? = nil
    var selectedVariationIndex = 0
    var cartSelectedIndex = -1
    var currentSelected = 0
    
    //cart details
    var resturantData : showRestaurantsRecords?
    var indexPath:IndexPath!
    var resturantDetailProtocol:ResturantDetailProtocol!
    var cartProducts : [RestaurantProduct] = []
    
    var selectedBtnType = ""
    var selectedSender:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalView.isHidden = true
        currentSelected = 0
        getCategories(email: (resturantData?.email)!)
        
        setResturantDetails()
        getCartsProduct()
    }
    
    @IBAction func giveFeedback(_ sender: Any) {
        let vc = ShowResturantRatingViewController()
        vc.resturantEmail = self.resturantData?.email ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        selectedBtnType = "fav"
        let email = UserStateHolder.loggedInUser?.email ?? ""
        
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            addItemToLike()
        }
        
        
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        let cartVc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        cartVc.isFromResturant = true
        self.navigationController?.pushViewController(cartVc, animated: false)
    }
    
    
    func setResturantDetails(){
        resturantNameLabel.text = resturantData?.name?.capitalizingFirstLetter()
        resturantDescriptionLabel.text = resturantData?.description
        if let raiting = Double(resturantData?.rating ?? "0.0"){
            ratingLabel.text = "\(round(raiting * 10) / 10.0)"
        }
        if let reviews = resturantData?.review_count{
            reviewsLabel.text = reviews + "\nReviews"
        }
        if let image = resturantData?.thumb{
            let imageUrl = BASEURL.imageUrl+image
            resturantImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }
        if let like = resturantData?.is_fav{
            if like == "0"{
               
                
                favourtieBackView.backgroundColor = UIColor(named: "AppDarkGrayColor")
            }else{
                favourtieBackView.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            }
        }
    }
    
    
    //MARK: - getCategories
    
    func getCategories(email: String){
//        loading.show(vc: self)
        let parameter = ["restaurant_email": email]
        APIService.sharedInstance.getCategories(parameters: parameter) { (resturantFoodCategoryResult) -> (Void) in
            self.resturantCategory = resturantFoodCategoryResult
            self.foodCategoryCollectionView.reloadData()
            if let category = self.resturantCategory?.records?.first
            {
                self.getProducts(categoryId: category.id!)
            }
            
            
        } failure: { (error) -> (Void) in
            
        }
    }
    
    
    func getProducts(categoryId: String){
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        
//        loading.show(vc: self)
        let parameter = ["email": email,
                         "category_id": categoryId]
        
        
        APIService.sharedInstance.getProducts(parameters: parameter) { (resturantProducts) -> (Void) in
            self.resturantProducts = resturantProducts
            let rows = self.resturantProducts?.records?.count ?? 0
//            self.tableViewExternalViewHeight.constant = CGFloat(150 * rows + 20)
            self.productsTableView.reloadData()
            
        } failure: { (error) -> (Void) in
            
        }
    }
    
    func addFavourite(user_email: String, islike: String, vendor_email: String){
//        loading.show(vc: self)
        let parameter = ["user_email": user_email, "islike": islike, "vendor_email": vendor_email]
        APIService.sharedInstance.addFavourite(parameters: parameter) { (addFavourite) -> (Void) in
            
            self.favouriteResult = addFavourite
            
        } failure: { (error) -> (Void) in
            
        }
    }

}

extension ResturantDetailViewController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturantProducts?.records?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resturantItemsCell", for: indexPath) as! ResturantItemsCell
        let data = resturantProducts?.records?[indexPath.row]
        cell.itemNameLabel.text = data?.name?.capitalizingFirstLetter()
        cell.itemDescriptionLabel.text = data?.productDescription?.capitalizingFirstLetter()
        cell.itemPriceLabel.text = data?.price
        
        if(data?.variationGroups?.count == 0){
            //show add to cart button
            
            if data?.quantity == "0"{
                cell.addToCartButton.isHidden = false
                cell.counterView.isHidden = true
            }else{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = false
                cell.quantityLabel.text = data?.quantity
            }
            
        }else{
            // do not show cart button
            
            if data?.quantity == "0"{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = true
            }else{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = false
                cell.quantityLabel.text = data?.quantity
            }
        }
        
        
        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        
        cell.plusButton.tag = indexPath.row
        cell.plusButton.addTarget(self, action: #selector(addItemToCart(sender:)), for: .touchUpInside)
        
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(popItemFromCart(sender:)), for: .touchUpInside)
        
        if let image = data?.images?.first?.image{
            let imageUrl = BASEURL.imageUrl+image
            cell.itemImageView.kf.setImage(with: URL(string: imageUrl))
        }
        
        return cell
    }


    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let item = resturantProducts?.records?[indexPath.row]
        if item?.variationGroups?.count != 0{
            let vc = ProductDetailViewController()
            vc.restaurantProduct = resturantProducts?.records?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @objc func addToCart(sender: UIButton){
        //check if the user logged in or not
        selectedBtnType = "cart"
        selectedSender = sender
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            ADDTOCART()
        }
        
    }
    
    @objc func addItemToCart(sender: UIButton){
        
        if let quantitynumber = Int(self.resturantProducts?.records?[sender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[sender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: sender.tag)
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            updateCartItemQuantity(id: (self.resturantProducts?.records?[sender.tag].id)!, user_email: user.email!, quantity: "\(value)")
        }
        
        
    }
    
    @objc func popItemFromCart(sender: UIButton){
        if let quantitynumber = Int(self.resturantProducts?.records?[sender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value - 1
            
            self.resturantProducts?.records?[sender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: sender.tag)
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            
            if value == 0{
                removetoCart(product_id: (self.resturantProducts?.records?[sender.tag].id)! , completion: { remove in
                })
              
            }else{
                updateCartItemQuantity(id: (self.resturantProducts?.records?[sender.tag].id)!, user_email: user.email!, quantity: "\(value)")
            }
            
            
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
        
        SVProgressHUD.show(withStatus: "Please Wait")
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parameter) { (errorMessage, error) in
            print("done")
            SVProgressHUD.dismiss()
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
    
    
    func addToCart(email: String, product_id: String, variation: String){
        let parameter = ["email": email,
                         "product_id": product_id,
                         "variations": variation]
        
        
        APIService.sharedInstance.addToCart(parameters: parameter) { (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
                
                print(AddToCart.errorMsg)
                if AddToCart.errorMsg == "Added to cart"{
                    self.resturantProducts?.records?[self.cartSelectedIndex].iscart = "1"
                    self.productsTableView.updateRow(row: self.cartSelectedIndex)
                    
//                    self.getProducts(categoryId: (self.resturantData?.id)!)
                }
            }
            
            
        }
        failure: { (error) -> (Void) in
            print(error)
        }
    }
}




extension ResturantDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resturantCategory?.records?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resturantFoodCategoryCell", for: indexPath) as! ResturantFoodCategoryCell
        
        cell.backGroundView.backgroundColor = currentSelected == indexPath.row ? UIColor.lightGray : UIColor.clear
        
        let data = resturantCategory?.records?[indexPath.row]
        cell.categoryLabel.text = data?.name
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.foodCategoryCollectionView.frame.width/4, height: self.foodCategoryCollectionView.frame.height - 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentSelected = indexPath.row
        foodCategoryCollectionView.reloadData()
        
        let data = resturantCategory?.records?[indexPath.row]
        
        getProducts(categoryId: (data?.id)!)
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}



//MARK: -           cart details
extension ResturantDetailViewController{
    func getCartsProduct() {
        cartProducts = []
        guard let user = UserStateHolder.loggedInUser else {
            return
        }
        guard let url = URL(string: URLPath.ShowCartProducts) else {
            print("URL Error")
            return
        }
        let parameter = ["email":user.email ?? ""]
        print(parameter)
        
        APIService.sharedInstance.getUserCart(parameters: parameter) { (restaurantProductResult) -> (Void) in
            if let products = restaurantProductResult.records{
                self.totalView.isHidden = false
                self.cartProducts = products
                self.totalPriceLabel.text = "Rs.\(self.Billprice())"
                self.totalCartCount.text = "\(self.cartProducts.count)"
            }
        } failure: { (error) -> (Void) in
            print("error occur and the rrir is \(error)")
        }

    }
    
    func Billprice()->Int{
        var totalbill:Int = 0
        for record in cartProducts{
            totalbill = totalbill+getPrice(record: record)
        }
        return totalbill
    }
    func getPrice(record:RestaurantProduct)->Int{
        var totalPrice = Int(record.price!)
        if record.variationGroups?.count == 0{
            // product which have no variation
            return totalPrice! * Int(record.quantity!)!
            
        }
        else{
            for variation in record.variationGroups!{
                for vari in variation.variations! {
                    if vari.isChecked!{
                        totalPrice = totalPrice! + Int(vari.price!)!
                    }
                }
               
                
            }
            return totalPrice! * Int(record.quantity!)!
        }
        
    }
    
}


extension UITableView{
    func updateRow(row: Int, section: Int = 0)
    {
        let indexPath = IndexPath(row: row, section: section)
        
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .automatic)
        self.endUpdates()
    }
    
}



extension ResturantDetailViewController:LoginProtocol{
    func loginDoneTapped() {
        if selectedBtnType == "fav"{
            addItemToLike()
        }else{
            ADDTOCART()
        }
        
    }
    
    func addItemToLike(){
        if let like = resturantData?.is_fav{
            if like == "0"{
                resturantData?.is_fav = "1"
                favourtieBackView.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
                
                if let vendorEmail = resturantData?.email{
                    guard let user = UserStateHolder.loggedInUser else{
                        return
                    }
                    
                    addFavourite(user_email: user.email!, islike: "1", vendor_email: vendorEmail)
                }
                
                
            }else{
                resturantData?.is_fav = "0"
                favourtieBackView.backgroundColor = UIColor(named: "AppDarkGrayColor")
                
                if let vendorEmail = resturantData?.email{
                    guard let user = UserStateHolder.loggedInUser else{
                        return
                    }
                    
                    addFavourite(user_email: user.email!, islike: "0", vendor_email: vendorEmail)
                }
            }
            
            guard let resturant = resturantData else{return}
            resturantDetailProtocol.resturantDetailHeartBtnTapped(indexPath: indexPath, resturantData: resturant)
        }
    }
    
    func ADDTOCART(){
        
        //update the row
        if let quantitynumber = Int(self.resturantProducts?.records?[selectedSender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[selectedSender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: selectedSender.tag)
        }
        
        //sending data to server
        let index = selectedSender.tag
        self.selectedVariationIndex = index
        self.cartSelectedIndex = index
        let data = resturantProducts?.records?[index]
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        if let product = data{
            guard let productId = product.id else {
                return
            }
            addToCart(email: user.email!, product_id: productId, variation: "0")
        }
    }
    
}




