//
//  ShowAllOrderToRiderViewController.swift
//  oye baryani
//
//  Created by Apple on 25/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class ShowAllOrderToRiderViewController: BaseViewController {}
//{
//    private let refreshControl = UIRefreshControl()
//
//    var userAllOrders:UserOrderRequestAPI?
//    var usersingleOrders:UserOrderSingleDataAPI?
//
//    @IBOutlet weak var userOrderTableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       if #available(iOS 10.0, *) {
//           userOrderTableView.refreshControl = refreshControl
//       } else {
//           userOrderTableView.addSubview(refreshControl)
//       }
//        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
//        refreshControl.attributedTitle = NSAttributedString(string: " Refreshing Data ...", attributes: nil)
//        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
//    }
//    @objc func refreshTableData(_ sender: Any){
//        ShowAllOrderDetail()
//
//    }
//    @IBAction func openSideMenu(_ sender: UIButton)
//    {
//
//        self.onSlideMenuButtonPressed(sender)
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//         if Connectivity.isConnectedToInternet()
//                {
//
//                    checkAcceptedOrder()
//                }
//                else{
//
//                     UIViewController.showAlertWithoutButton(inViewController: self, message: "No Internet Connection")
//                }
//    }
//
//
//    func ShowAllOrderDetail(){
//
//               let urlstring = "https://oyebiryani.com/api/showAllOrders.php"
//             guard let url = URL(string: urlstring) else {
//                      print("URL Error")
//                      return
//                  }
//           //  SVProgressHUD.show(withStatus: "Loading")
//        EMartAPIManager.shared.getAllUserOrders(url: url, parameter: nil) { (userAllOrders, error) in
//            self.refreshControl.endRefreshing()
//         //   SVProgressHUD.dismiss()
//
//            if error == false
//            {
//                self.userAllOrders = userAllOrders
//
//                self.userOrderTableView.reloadData()
//            }
//            else{
//                UIViewController.showAlertWithoutButton(inViewController: self, message: "Error While Showing Order Data")
//
//            }
//        }
//
//    }
//
//    func checkAcceptedOrder(){
//
//
//        let urlstring = "https://oyebiryani.com/api/showAccptedOrders.php"
//                guard let url = URL(string: urlstring) else {
//                         print("URL Error")
//                         return
//                     }
//               SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
//                         SVProgressHUD.show(withStatus: "Loading")
//        let parameter:[String:Any] = ["email":OyeBaryaniSessions.shared._UserProfileInfo?.email ?? ""]
//        EMartAPIManager.shared.getRiderAcceptedOrders(url: url, parameter: parameter) { (userAllOrders, error) in
//               SVProgressHUD.dismiss()
//
//
//               if error == false
//               {
//                   self.usersingleOrders = userAllOrders
//                let view = self.storyboard?.instantiateViewController(identifier: "UserOrderDetailToRiderViewController") as! UserOrderDetailToRiderViewController
//                view.userOrder = self.usersingleOrders?.records; self.navigationController?.pushViewController(view, animated: true)
//               }
//               else{
//                self.ShowAllOrderDetail()
//                //UIViewController.showAlertWithoutButton(inViewController: self, message: "Error While Showing Order Data")
//
//               }
//           }
//    }
//
//
//
//}
//extension ShowAllOrderToRiderViewController:UITableViewDelegate,UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return userAllOrders?.records?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowAllOrderToRiderTableViewCell", for: indexPath) as!  ShowAllOrderToRiderTableViewCell
//        cell.setData(records: (userAllOrders?.records?[indexPath.item])!)
//        cell.orderAcceptButton.tag = indexPath.item
//        cell.orderViewButtonDelivring.tag = indexPath.item
//        cell.orderViewButtonProcessing.tag = indexPath.item
//            cell.orderAcceptButton.addTarget(self, action: #selector(acceptOrder(sender:)), for: .touchUpInside)
//            cell.orderViewButtonDelivring.addTarget(self, action: #selector(ViewOrderDetailDelivered(sender:)), for: .touchUpInside)
//            cell.orderViewButtonProcessing.addTarget(self, action: #selector(ViewOrderDetailProcessing(sender:)), for: .touchUpInside)
//            
//            return cell
//    }
//    @objc func acceptOrder(sender:UIButton)
//    {
//        AcceptOrder(order_id: self.userAllOrders?.records?[sender.tag].order_number ?? "0")
//        
//        print("accept order tapped: \(sender.tag)")
//        
//    }
//    @objc func ViewOrderDetailProcessing(sender:UIButton)
//    {
//        let view = self.storyboard?.instantiateViewController(identifier: "UserOrderDetailToRiderViewController") as! UserOrderDetailToRiderViewController
//        view.userOrder = self.userAllOrders?.records?[sender.tag]; self.navigationController?.pushViewController(view, animated: true)
//       print("View order processing: \(sender.tag)")
//        
//    }
//    @objc func ViewOrderDetailDelivered(sender:UIButton)
//       {
//        let view = self.storyboard?.instantiateViewController(identifier: "UserOrderDetailToRiderViewController") as! UserOrderDetailToRiderViewController
//        view.userOrder = self.userAllOrders?.records?[sender.tag]; self.navigationController?.pushViewController(view, animated: true)
//
//        print("View order Delivering: \(sender.tag)")
//           
//       }
//    
//    
//    
//}
//extension  ShowAllOrderToRiderViewController
//{
//    func AcceptOrder(order_id:String){
//
//          let urlstring = "https://oyebiryani.com/api/orderAccepted.php"
//        let paramerter:[String:Any] = ["email":OyeBaryaniSessions.shared._UserProfileInfo?.email ?? "","order_id":order_id]
//
//                    guard let url = URL(string: urlstring) else {
//                        print("URL Error")
//                        return
//                    }
//        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
//
//
//
//                        if error == false
//                        {
//                            self.checkAcceptedOrder()
//
//                        }
//                        else{
//                            UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
//                        }
//                    }
//
//
//    }
//
//}
