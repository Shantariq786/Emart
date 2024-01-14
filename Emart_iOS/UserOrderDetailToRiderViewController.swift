//
//  UserOrderDetailToRiderViewController.swift
//  oye baryani
//
//  Created by Apple on 25/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD
class UserOrderDetailToRiderViewController: UIViewController {
  
    var latitude:Double?
    var longitude:Double?
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var number_Items: UILabel!
    @IBOutlet weak var Status_Label: UILabel!
    @IBOutlet weak var userorderNumberLabel: UILabel!
    @IBOutlet weak var useraddressLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var TotalBill: UILabel!
    @IBOutlet weak var userName: UILabel!
    var cartsProducts:orderProductAPI?
    
    @IBOutlet weak var CancelOrderButton: UIButton!
    @IBOutlet weak var DispatchorDeliverdButton: UIButton!
    @IBAction func PopNavigationController(_ sender: UIButton){
           self.navigationController?.popViewController(animated: true)
       }

    @IBAction func ShowMapLocation(_ sender: UIButton){
        UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/@\(latitude ?? 0.0),\(longitude ?? 0.0),6z")!)
        
    }
    
    @IBAction func firstPhoneNo(_ sender: UIButton)
    {
        if userOrder != nil{
            if let phonenumber = userOrder?.mobile_number{
        makePhoneCall(phoneNumber: phonenumber)
            }
        }
    }
    @IBAction func secondPhoneNo(_ sender: UIButton)
    {
         if userOrder != nil{
            if let phonenumber = userOrder?.sec_mobile{
                makePhoneCall(phoneNumber: phonenumber)
                    }
                }
        
    }
    func makePhoneCall(phoneNumber: String) {

        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {

            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
var userOrder:UserOrderRequestRecords?
    override func viewDidLoad() {
        super.viewDidLoad()
if userOrder != nil
      {
        if let locationCordinates = userOrder?.location?.split(separator: ",")
        {
            latitude = Double(locationCordinates[0])
            longitude = Double(locationCordinates[1])
        }
        userName.text = userOrder?.name
        TotalBill.text = "RS \(userOrder?.total_price ?? "0")"
        useremailLabel.text = userOrder?.user_email
        orderNumberLabel.text = userOrder?.order_number
        orderDate.text = userOrder?.date_time
        Status_Label.text = userOrder?.status_name
        userorderNumberLabel.text = userOrder?.order_number
        number_Items.text = "\(userOrder?.count ?? "0") Item(s)"
        useraddressLabel.text = userOrder?.address
        
        CartsProducts(orderID:userOrder?.order_number ?? "")
        if (userOrder?.status == "2")
        {
            CancelOrderButton.isHidden = false
            DispatchorDeliverdButton.isHidden = false
            DispatchorDeliverdButton.setTitle("Dispatched", for: .normal)
            DispatchorDeliverdButton.backgroundColor =
                UIColor.init(red: 191/255, green: 44/255, blue: 37/255, alpha: 1)
        }
        else if (userOrder?.status == "3")
        {
           
            CancelOrderButton.isHidden = false
                       DispatchorDeliverdButton.isHidden = false
            DispatchorDeliverdButton.setTitle("Delivered", for: .normal)
            DispatchorDeliverdButton.backgroundColor =
                UIColor.init(red: 70/255, green: 207/255, blue: 27/255, alpha: 1)
             //  UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
        }
      
       
        }
  
    }
    func CartsProducts(orderID:String){
          
              guard let url = URL(string:"https://oyebiryani.com/api/showOrderItems.php") else {
              print("url error")
                  return
              }
               let parameters:[String:Any] =  ["order_num" :orderID ]
           
        EMartAPIManager.shared.getOrderDetailProduct(url: url, parameter: parameters) { (cartsproduct, error) in
                  if error == false{
                  
                  self.cartsProducts = cartsproduct
                   self.orderDetailTableView.reloadData()
              }
               }
        
            
              
              
          
         
       
       }
    
    
    @IBAction func DispatchedorDileverdButton(_ sender: UIButton)
    {
        if let checkStatus = userOrder?.status,let order_number = userOrder?.order_number
        {
            if checkStatus == "2"
            {
                ConfirmationAlert(Title: "", message: "Are You Want To Dispatched Order", status: checkStatus, order_id: order_number)
            }
            else if checkStatus == "3"
            {
                self.DileveredOrder(order_id: order_number)
                
                
                
            }
        }
        
        
    }
    
    @IBAction func CamcelButtonTapped(_ sender: UIButton)
    {
        if let orderno = userOrder?.order_number
        {
        CancelOrder(order: orderno)
        }
        
    }
    
    func CancelOrder(order:String){
       
             let urlstring = "https://oyebiryani.com/api/orderCancleRider.php"
           let paramerter:[String:Any] = ["order_id":order]
                       
                       guard let url = URL(string: urlstring) else {
                           print("URL Error")
                           return
                       }
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
                           if error == false
                           {
                              self.navigationController?.popViewController(animated: true)
                               
                           }
                           else{
                               UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
                           }
                       }
                       
               
                     
       }
      
    


}
//extension UserOrderDetailToRiderViewController:UITableViewDataSource,UITableViewDelegate
//{
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return self.cartsProducts?.records?.count ?? 0
//       }
//       
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           let ordercells = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as!
//           OrderDetailTableViewCell
//           ordercells.setData(records: (self.cartsProducts?.records?[indexPath.row])!)
//           return ordercells
//       }
//        
//    
//    
//}
extension UserOrderDetailToRiderViewController
{
    func DispathOrder(order_id:String){
       
             let urlstring = "https://oyebiryani.com/api/orderDispatch.php"
           let paramerter:[String:Any] = ["order_id":order_id]
                       
                       guard let url = URL(string: urlstring) else {
                           print("URL Error")
                           return
                       }
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
                          
                                
                                     
                           if error == false
                           {
                            self.checkAcceptedOrder(completion: { load in
                                self.viewDidLoad()
                                
                            })
                               
                           }
                           else{
                               UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
                           }
                       }
                       
                     
       }

    func DileveredOrder(order_id:String){
          
                let urlstring = "https://oyebiryani.com/api/orderDelivered.php"
              let paramerter:[String:Any] = ["order_id":order_id]
                          
                          guard let url = URL(string: urlstring) else {
                              print("URL Error")
                              return
                          }
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
                             
                                   
                                        
                              if error == false
                              {
                               
                                self.navigationController?.popViewController(animated: true)
                              }
                              else{
                                  UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
                              }
                          }
                          
                        
          }
    
    
    
    func ConfirmationAlert(Title:String,message:String,status:String,order_id:String)
    {
        let Alert = UIAlertController(title: Title, message: message, preferredStyle: .alert)
       Alert.addAction( UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        if status == "2"
        {
            self.DispathOrder(order_id:order_id)
        }
            
        })
        
        Alert.addAction( UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(Alert, animated: true, completion: nil)
        
        
        
        
        
    }
    func checkAcceptedOrder(completion:@escaping (Bool)->Void){
          
         
          let urlstring = "https://oyebiryani.com/api/showAccptedOrders.php"
                  guard let url = URL(string: urlstring) else {
                           print("URL Error")
                           return
                       }
                  SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
                           SVProgressHUD.show(withStatus: "Loading")
//          let parameter:[String:Any] = ["email":OyeBaryaniSessions.shared._UserProfileInfo?.email ?? ""]
        EMartAPIManager.shared.getRiderAcceptedOrders(url: url, parameter: ["":""]) { (userAllOrders, error) in
                 SVProgressHUD.dismiss()
             
                      
                 if error == false
                 {
                    self.userOrder = userAllOrders?.records
                 
                    completion(true)
                 }
                 else{
                    completion(true)
                    UIViewController.showAlertWithoutButton(inViewController: self, message: "error while Loading Data")
                  
                     
                 }
             }
      }
      
    

      
    
}
