//
//  OrderDetailViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 08/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class OrderDetailViewController: UIViewController, ChatButtonTappedProtocol {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var runnerOrderCallView: UIView!
    @IBOutlet weak var pastOederCallButton: UIButton!
    
    var orderData : Order?
    var orderRider:orderRider?
    
    var allItems = [OrderItemsRecord]()
    var isRunning = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ItemTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.cell_identifier)
        
        tableView.register(UINib(nibName: OrderDescriptionTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderDescriptionTableViewCell.cell_identifier)
        
        tableView.register(UINib(nibName: ContactRiderTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: ContactRiderTableViewCell.cell_identifier)
        
        tableView.register(UINib(nibName: OrderStatusTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderStatusTableViewCell.cell_identifier)
        
        tableView.register(UINib(nibName: OrderDetailPriceTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderDetailPriceTableViewCell.cell_identifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getOrderItems()
        getRiderDetails()
        if isRunning{
            pastOederCallButton.isHidden = true
            runnerOrderCallView.isHidden = false
        }else{
            pastOederCallButton.isHidden = false
            runnerOrderCallView.isHidden = true
        }
        //getTokeDetail()
    }
    
    @IBAction func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func moveToChat() {
        guard let orderNumber = orderData?.orderNumber else {
            return
        }
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        let vc = ChatViewController()
        vc.id = orderNumber
        vc.currentUser = user.email!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getOrderItems(){
        
        //here we will take user parameters
        guard let orderNumber = orderData?.orderNumber else {
            return
        }
        let parameters =  ["order_num" : orderNumber]
        
        APIService.sharedInstance.getOrderItems(parameters: parameters) { (orderItems) -> (Void) in
            if let items = orderItems.records{
                self.allItems = items
                
                if self.allItems.count >= 0 {
                    self.tableView.reloadData()
                }
                print(orderItems)
            }
        } failure: { (error) -> (Void) in
            
        }
    }
    
    func getRiderDetails(){
        
        guard let orderNumber = orderData?.orderNumber else {
            return
        }
        let params: [String: Any] = ["order_num":orderNumber]
        
        APIService.sharedInstance.getSpecificOrderDetail(parameters: params) { (specificOrder) -> (Void) in
            //self.orderRider = specificOrder.records?[0].rider
        } failure: { (error) -> (Void) in
            print("error occur")
        }
        
    }
    
    
    
}
extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 3{
            return 1
        }else if section == 2{
            return getOrderStatusArray().count
        }else{
            return allItems.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDescriptionTableViewCell.cell_identifier, for: indexPath) as! OrderDescriptionTableViewCell
            let data = orderData
            cell.descriptionNoLabel.text = data?.orderNumber
            cell.descriptionPriceLabel.text = "Rs \( data?.totalPrice ?? "0")"
            cell.descriptionAddressLabel.text = data?.address
            cell.descriptionStreetAddressLabel.text = data?.gpsAddress
            cell.descriptionItemsCountLabel.text = "\(data?.count ?? "0") item"
            cell.descriptionCancelLabel.text = data?.statusName
            cell.descriptionNoteLabel.text = data?.descriptionField
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactRiderTableViewCell.cell_identifier, for: indexPath) as! ContactRiderTableViewCell
            if orderRider != nil{
                cell.setData(rider: orderRider!)
            }
            cell.chatButtonTappedProtocol = self
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderStatusTableViewCell.cell_identifier, for: indexPath) as! OrderStatusTableViewCell
            cell.statusNumber.text = String(indexPath.row+1)
            cell.statusValue.text = getOrderStatusArray()[indexPath.row]
            return cell
        }
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailPriceTableViewCell.cell_identifier, for: indexPath) as! OrderDetailPriceTableViewCell
            cell.totalPriceLabel.text = "Rs.\(orderData!.totalPrice ?? "0")"
            cell.noOfItems.text = "\(orderData!.count ?? "0") item(s)"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.cell_identifier, for: indexPath) as! ItemTableViewCell
            if allItems.count > 0{
                let data = allItems[indexPath.row]
                let image = data.images?.first?.image ?? ""
                cell.itemNameLabel.text = data.name
                cell.itemPriceLabel.text = "RS \(data.price!)"
                cell.itemQtyLabel.text = "Qty : \(data.quantity!)"
                return cell
            }else{
                return UITableViewCell()
            }
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 220
        }else if indexPath.section == 3{
            return 200
        }
        else if indexPath.section == 1{
            if orderRider == nil{
                return 0
            }else{
                return 8
            }
            
        }
        else{
            return 80
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func getOrderStatusArray() -> [String]{
        var statusArray = [String]()
        let currentOrderStatus = Int(orderData!.status!)
        if(currentOrderStatus == 1){
            statusArray.append("Pending")
        }else if (currentOrderStatus == 2){
            statusArray.append("Pending")
            statusArray.append("Processing")
            
        }else if (currentOrderStatus == 3){
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            
        }else if (currentOrderStatus == 4){
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            statusArray.append("Cancel by rider")
            
        }else if (currentOrderStatus == 5){
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            statusArray.append("Cancel by rider")
            statusArray.append("Cancel by Resturant")
            
        }else if (currentOrderStatus == 6){
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            statusArray.append("Cancel by rider")
            statusArray.append("Cancel by Resturant")
            statusArray.append("Cancel by User")
            
        }else if (currentOrderStatus == 7){
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            statusArray.append("Cancel by rider")
            statusArray.append("Cancel by Resturant")
            statusArray.append("Cancel by Delivered")
            
        }else{
            statusArray.append("Pending")
            statusArray.append("Processing")
            statusArray.append("Dispatched")
            statusArray.append("Cancel by rider")
            statusArray.append("Cancel by Resturant")
            statusArray.append("Delivered")
            statusArray.append("Timeout Canceled")
        }
        return statusArray
    }
    
    
}
