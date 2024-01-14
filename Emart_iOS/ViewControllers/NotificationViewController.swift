//
//  NotificationViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/17/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import PopupDialog

class NotificationViewController: UIViewController {

    var notifications = [NotificationsRecord]()
    var popup:PopupDialog!
    var selectedIndexPath:IndexPath!
    
    @IBOutlet weak var readAllBtn: UIButton!
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var noNotificationsView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationsTableView.register(UINib(nibName: NotificationsTableViewCell.cell_identifier, bundle: nil), forCellReuseIdentifier: NotificationsTableViewCell.cell_identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAccountView.isHidden = true
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            createAccountView.isHidden = false
        }else{
            getNotifications()
        }
        
    }
    
    @IBAction func createAccountBtnTapped(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
        vc.loginProtocol = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func readAllTapped(_ sender: Any) {
        readAllNotifications()
    }
    
    
    func readAllNotifications(){
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        let parameters =  ["user_email" : user.email ?? ""]
        
        APIService.sharedInstance.ReadAllNotification(parameters: parameters) { result in
            print("error ",result.status ?? false)
            self.getNotifications()
        } failure: { error in
            print("error ",error)
        }
        
        
    }
    
    func getNotifications(){
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        let parameters =  ["email" : user.email ?? ""]
        print("parameters ",parameters)
        
        APIService.sharedInstance.getNotifications(parameters: parameters) { (Notifications) -> (Void) in
            if let notifications = Notifications.NotificationsRecord{
                self.notifications = notifications
                print("self.notifications.count == 0  ",self.notifications.count == 0 )
                if self.notifications.count == 0 {
                    self.noNotificationsView.isHidden = false
                }else{
                    self.noNotificationsView.isHidden = true
                }
                self.notificationsTableView.reloadData()
                
               
            }else{
                self.readAllBtn.isHidden = true
            }
            
        } failure: { (error) -> (Void) in
            print("error occur while fetching notifications ",error)
        }
        
    }
    
}


extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notificationsTableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.cell_identifier, for: indexPath) as! NotificationsTableViewCell
        if notifications.count > 0{
            let data = notifications[indexPath.row]
            cell.setData(notification: data)
            cell.selectionStyle = .none
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        showAlertPopUp()
        


    }
    
}


extension NotificationViewController{
    func showAlertPopUp(){
        let header = "Order No \(notifications[selectedIndexPath.row].order_id ?? "")"
        let subHeader = notifications[selectedIndexPath.row].message ?? ""
        
        let timePicker = AlertPopUpViewController(nibName: "AlertPopUpViewController", bundle: nil)
        popup = PopupDialog(viewController: timePicker, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false,panGestureDismissal: false)
        
        timePicker.setUpData(headerText: header, subHeaderText:subHeader , animation: "rider")
        timePicker.doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        present(popup, animated: true, completion: nil)
        
        
    }
    
    @objc func doneAction(){
        
        popup.dismiss()
        if Int(notifications[selectedIndexPath.row].isread ?? "0")! == 0{
            notifications[selectedIndexPath.row].isread = "1"
            notificationsTableView.reloadRows(at: [selectedIndexPath], with: .none)
            readNotification()
        }
    }
    
    func readNotification(){
        let params:[String:Any] = ["notification_id":notifications[selectedIndexPath.row].id!]
        APIService.sharedInstance.ReadNotification(parameters: params) { result in
            print("error ",result.status ?? false)
        } failure: { error in
            print("error ",error)
        }
    }
}


extension NotificationViewController:LoginProtocol{
    func loginDoneTapped() {
        createAccountView.isHidden = true
    }
    
    
}
