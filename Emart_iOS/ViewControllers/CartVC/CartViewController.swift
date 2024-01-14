//
//  cartViewController.swift
//  oye baryani
//
//  Created by Apple on 28/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class CartViewController: UIViewController {

    
    @IBOutlet weak var CartTotalView: CardView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var TotalBillPrice: UILabel!
    @IBOutlet weak var noCartItemView: UIView!
    
    @IBOutlet weak var createAccountView: UIView!
    
    var cartProducts : [RestaurantProduct] = []
    
    @IBOutlet weak var goBackBtn:UIButton!
    var isFromResturant = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFromResturant == true{
            goBackBtn.setTitle("Back", for: .normal)
            goBackBtn.isUserInteractionEnabled = true
        }else{
            goBackBtn.setTitle("Cart", for: .normal)
            goBackBtn.isUserInteractionEnabled = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAccountView.isHidden = true
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            createAccountView.isHidden = false
        }else{
            getCartsProduct()
        }
        
    }
    
    
    @IBAction func createAccountBtnTapped(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
        vc.loginProtocol = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    @IBAction func goBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pushNavigationController(_ sender: UIButton){
         UserDefaults.standard.set("yes", forKey: "can_Order")
        let canOrder = UserDefaults.standard.value(forKey: "can_Order") as? String
        let resturantstatus = UserDefaults.standard.value(forKey: "open_close") as? String
        if canOrder == nil{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Can't Order till your previous Order  Deliverd")
        }
            else if(resturantstatus == "0"){
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Can't Order Resturant is Closed")
        }
        else{
            let view = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    @IBAction func PopNavigationController(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension CartViewController  {
    @objc func AddQuantity(sender:UIButton) {
        print(sender.tag)
        let index = sender.tag
        if let quantitynumber = Int(self.cartProducts[sender.tag].quantity ?? "0")        {
            var value = quantitynumber
            value = value + 1
//            self.cartsproduct?.records?[sender.tag].quantity = "\(value)"
//            self.cartTableView.updateRow(row: index)
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            updateCartItemQuantity(id: (self.cartProducts[sender.tag].id)!, quantity: "\(value)", user_email: user.email!, completion: { update in
                if update == true{
                    self.getCartsProduct()
                }
            })
        }
    }
    @objc func RemoveQuantity(sender:UIButton){
        print(sender.tag)
        if let quantitynumber = Int(self.cartProducts[sender.tag].quantity ?? "0"){
            if quantitynumber > 1{
                var value = quantitynumber
                value = value - 1
                guard let user = UserStateHolder.loggedInUser else{
                    return
                }
                updateCartItemQuantity(id: (self.cartProducts[sender.tag].id)!, quantity: "\(value)", user_email: user.email!, completion: { update in
                    if update == true{
                        self.getCartsProduct()
                    }
                })
            }
            
        }
    }
    @objc func RemoveProduct(sender:UIButton) {
        print("remove product tapped")
        removetoCart(product_id: self.cartProducts[sender.tag].id ?? "0", completion: { remove in
        })
    }
}

extension CartViewController{
    func updateBill(){
          TotalBillPrice.text = "RS \(Billprice())"
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
                self.getCartsProduct()
            }
            else{
                completion(false);
                UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
        }
    }
    
    func updateCartItemQuantity(id:String,quantity:String,user_email: String,completion:@escaping ((Bool)->Void)){
        let urlstring = URLPath.UpdateCart// "https://emart.pkgadget.com/api/updateCartItemQuantity.php"
        let paramerter = ["id":id,"quantity":quantity, "user_email": user_email]
        guard let url = URL(string: urlstring) else {
            print("URL Error")
            return
        }
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
            if error == false{
                completion(true); UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
            else{
                completion(false);  UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
        }
    }
    
    
    

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
            print(restaurantProductResult)
            if let products = restaurantProductResult.records{
                print("come in if")
                self.noCartItemView.isHidden = true
                self.cartProducts = products
                self.reloadTable()
            }else{
                print("come in else")
                self.noCartItemView.isHidden = false
            }
        } failure: { (error) -> (Void) in
            print("error occur and the rrir is \(error)")
        }

    }
    func reloadTable(){
//        cartCellArray.removeAll()
        self.cartTableView.reloadData()
        self.cartTableView.performBatchUpdates(nil, completion: {
            (result) in
            self.updateBill()
        })
    }
}

extension CartViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartProducts.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.setProduct(record: self.cartProducts[indexPath.row])
               cell.add.tag = indexPath.row
               cell.subtract.tag = indexPath.row
               cell.remove.tag = indexPath.row
            cell.add.addTarget(self, action: #selector(AddQuantity(sender:)), for: .touchUpInside)
            cell.subtract.addTarget(self, action: #selector(RemoveQuantity(sender:)), for: .touchUpInside)
            cell.remove.addTarget(self, action: #selector(RemoveProduct(sender:)), for: .touchUpInside)
//            cartCellArray.append(cell)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    
}


extension CartViewController:LoginProtocol{
    func loginDoneTapped() {
        createAccountView.isHidden = true
    }
    
    
}
