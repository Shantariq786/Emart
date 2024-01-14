//
//  MyOrdersViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    
    @IBOutlet weak var noOrderView:UIView!
    
    var allOrders = [Order]()
    var filteredOrders = [Order]()
    
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var runningOrderButton:UIButton!
    @IBOutlet weak var pastOrderButton:UIButton!
    var isRunning = true
    
    var runningOrders = ["1","2","3"]
    
    var pastOrders = ["4","5","6","7","8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: MyOrdersTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: MyOrdersTableViewCell.cell_identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allOrders.removeAll()
        filteredOrders.removeAll()
        
        getUserOrders()
    }

    
    func getUserOrders(){
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        //here we will take user parameters
        let parameters =  ["user_email" : user.email ?? ""]
        
        APIService.sharedInstance.getUserOrders(parameters: parameters) { (orderResult) -> (Void) in
            if let orders = orderResult.records{
                self.allOrders = orders
                self.filteredOrders = self.allOrders.filter({self.runningOrders.contains($0.status!)})
                
                if self.filteredOrders.count == 0 {
                    self.noOrderView.isHidden = false
                }else{
                    self.noOrderView.isHidden = true
                }
                
                self.tableView.reloadData()
            }
        } failure: { (error) -> (Void) in
            
        }
        
    }
    
    @IBAction func goBack(){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func orderButtonAction(_ sender:UIButton){
        
        if sender.tag == 0 {
            //Runnign Order
            isRunning = true
            self.runningOrderButton.setTitleColor(UIColor.white, for: .normal)
            self.runningOrderButton.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            self.pastOrderButton.setTitleColor(AppBlackColor(), for: .normal)
            self.pastOrderButton.backgroundColor = .white
            self.filteredOrders = self.allOrders.filter({self.runningOrders.contains($0.status!)})
            if self.filteredOrders.count == 0 {
                self.noOrderView.isHidden = false
            }else{
                self.noOrderView.isHidden = true
            }
            
            self.tableView.reloadData()
            
 
        }else{
            isRunning = false
            
            self.pastOrderButton.setTitleColor(UIColor.white, for: .normal)
            self.pastOrderButton.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            self.runningOrderButton.setTitleColor(AppBlackColor(), for: .normal)
            self.runningOrderButton.backgroundColor = .white
            self.filteredOrders = self.allOrders.filter({self.pastOrders.contains($0.status!)})
            if self.filteredOrders.count == 0 {
                self.noOrderView.isHidden = false
            }else{
                self.noOrderView.isHidden = true
            }
            self.tableView.reloadData()
        }
        
    }
    
    var cancelResult : OrderCancel?
    func cancelOrders(order_id: String , index:Int){
       
        //here we will take user parameters
        let parameters =  ["order_id" : order_id]
        print("parameters \(parameters)")
        APIService.sharedInstance.cancelOrders(parameters: parameters) { (cancelOrder) -> (Void) in
            if let result = cancelOrder.error{
                if result == false{
                    self.filteredOrders.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
                    self.getUserOrders()
                }else{
                    print(cancelOrder.errorMsg!)
                }
                
            }
        } failure: { (error) -> (Void) in
            
        }
        
    }

}


extension MyOrdersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrdersTableViewCell.cell_identifier, for: indexPath) as! MyOrdersTableViewCell
        cell.indexPath = indexPath
        cell.myOrderProtocol = self
        cell.setData(records:filteredOrders[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if filteredOrders[indexPath.row].status == "1" || filteredOrders[indexPath.row].status == "2" || filteredOrders[indexPath.row].status == "7"{
            return 250
        }else{
            return 190
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailsViewController()
        vc.orderData = filteredOrders[indexPath.row]
        if isRunning{
            vc.isRunning = true
        }else{
            vc.isRunning = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension MyOrdersViewController:MyOrderProtocol{
    func cancelBtnTapped(indexPath: IndexPath) {
        
        let data = filteredOrders[indexPath.row]
        if let orderId = data.orderNumber{
            cancelOrders(order_id: orderId,index:indexPath.row)
        }
        
    }
    
    func addReviewTapped(indexPath: IndexPath) {
        let data = filteredOrders[indexPath.row]
        if let rId = data.rId{
            let vc = AddFeedbackViewController()
            vc.restaurantId = rId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
