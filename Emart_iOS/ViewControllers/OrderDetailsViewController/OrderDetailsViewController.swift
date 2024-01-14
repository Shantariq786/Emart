//
//  OrderDetailsViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 17/11/2021.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    

    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    var orderData : Order?
    var orderFullDetails:OrderDetailModel?
    
    var allItems = [OrderItemsRecord]()
    var isRunning = true
    
    var status:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("order id ",orderData?.orderNumber)
        orderDetailsTableView.register(UINib(nibName: OrderCurrentStatusTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderCurrentStatusTableViewCell.cell_identifier)
        
        orderDetailsTableView.register(UINib(nibName: "OrderMapLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderMapLocationTableViewCell")
        
        orderDetailsTableView.register(UINib(nibName: OrderCurrentTitleTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderCurrentTitleTableViewCell.cell_identifier)
        
        orderDetailsTableView.register(UINib(nibName: OrderCurrentVenderDetailsTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderCurrentVenderDetailsTableViewCell.cell_identifier)
        
        orderDetailsTableView.register(UINib(nibName: ItemTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.cell_identifier)
        
        orderDetailsTableView.register(UINib(nibName: OrderDetailPriceTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: OrderDetailPriceTableViewCell.cell_identifier)
        
        status = getStatusValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getOrderItems()
        getOrderFullDetails()
    }

    @IBAction func goBackBtnTapped(_ sender: Any) {
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
                    self.orderDetailsTableView.reloadData()
                }
            }
        } failure: { (error) -> (Void) in
            
        }
    }

    func getOrderFullDetails(){
        
        guard let orderNumber = orderData?.orderNumber else {
            return
        }
        let params: [String: Any] = ["order_num":orderNumber]
        
        APIService.sharedInstance.getSpecificOrderDetail(parameters: params) { (specificOrder) -> (Void) in
            self.orderFullDetails = specificOrder
            self.orderDetailsTableView.reloadSections([1], with: .none)
        } failure: { (error) -> (Void) in
        }
        
    }
    
    func getStatusValue()->Int{
        let status = Int(orderData?.status ?? "") ?? 0
        return status
    }
    
}

//MARK: -       TABLEVIEW PROTOCOLS

extension OrderDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 || section == 4{
            return 1
        }else{
            return allItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderCurrentStatusTableViewCell.cell_identifier, for: indexPath) as! OrderCurrentStatusTableViewCell
            cell.setData(status: status)
            cell.selectionStyle = .none
            return cell
        }
        
        else if indexPath.section == 1{
            // here we have to show animation or map
            let status = orderData!.status
            if status == "3"{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderMapLocationTableViewCell", for: indexPath) as! OrderMapLocationTableViewCell
                cell.trackerOrderBtn.tag = indexPath.row
                cell.trackerOrderBtn.addTarget(self, action: #selector(trackOrder(sender:)), for: .touchUpInside)
                cell.setData(orderFullDetails: orderFullDetails)
                cell.selectionStyle = .none
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: OrderCurrentTitleTableViewCell.cell_identifier, for: indexPath) as! OrderCurrentTitleTableViewCell
                cell.setData(status: status!)
                cell.selectionStyle = .none
                return cell
            }
            
            
        }
        
        
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderCurrentVenderDetailsTableViewCell.cell_identifier, for: indexPath) as! OrderCurrentVenderDetailsTableViewCell
            cell.setData(venderName: orderData!.name ?? "", orderId: "Order id #\(orderData!.orderNumber ?? "")", status: status)
            cell.indexPath = indexPath
            cell.orderCurrentVenderProtocol = self
            cell.selectionStyle = .none
            return cell
        }
        
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.cell_identifier, for: indexPath) as! ItemTableViewCell
            if allItems.count > 0{
                let data = allItems[indexPath.row]
                cell.itemNameLabel.text = data.name
                cell.itemPriceLabel.text = "RS \(data.price!)"
                cell.itemQtyLabel.text = "\(data.quantity!)x"
                cell.selectionStyle = .none
                return cell
            }
            else{
                return UITableViewCell()
            }
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailPriceTableViewCell.cell_identifier, for: indexPath) as! OrderDetailPriceTableViewCell
            
            cell.noOfItems.text = "\(orderData!.count ?? "0") item(s)"
            cell.deliveryAdress.text = orderData!.address ?? ""
            cell.estimtedDate.text = "-10 mins , 0 mins"
            cell.totalSemiPriceLabel.text = "Rs.\(orderData!.totalPrice ?? "0")"
            cell.deliveryCharges.text = "Rs.0"
            cell.deliveryCharges.text = "Rs.\(orderData!.totalPrice ?? "0")"
            cell.selectionStyle = .none
            return cell
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if status == 4 || status == 5 || status == 6 || status == 7{
                return 0
            }else{
                return 80.0
            }
            
        } else if indexPath.section == 1{
            return 200
            
        }else if indexPath.section == 2{
            
            if status == 4 || status == 5 || status == 6 || status == 7{
                return 140
            }else{
                return 190.0
            }
            
        }else if indexPath.section == 3{
            return 30
        }else{
            return 300
        }
    }
    
    @objc func trackOrder(sender:UIButton){
        let vc = TrackRiderViewController()
        vc.order = self.orderData
        vc.orderFullDetails = self.orderFullDetails
        
        //guard let orderId =  self.orderData?.id else {return}
        guard let orderId =  self.orderFullDetails!.records![0].rider?.id else {return}
        
        //print("self.orderData?.rId ",)
        //print("orderId ",orderId)
        vc.orderID = Int(orderId) ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension OrderDetailsViewController:OrderCurrentVenderProtocol{
    func addReviewTapped(indexPath: IndexPath) {
        print("add review tapped")
    }
    
    func cancelOrderTapped(indexPath: IndexPath) {
        print("cancel tapped")
        
        cancelOrders(order_id: orderData?.orderNumber ?? "")
    }
    
    func cancelOrders(order_id: String){
       
        //here we will take user parameters
        let parameters =  ["order_id" : order_id]
        print("parameters \(parameters)")
        APIService.sharedInstance.cancelOrders(parameters: parameters) { (cancelOrder) -> (Void) in
            if let result = cancelOrder.error{
                if result == false{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    print("error occur while removing file ",cancelOrder.errorMsg!)
                }
                
            }
        } failure: { (error) -> (Void) in
            
        }
        
    }
    
}
