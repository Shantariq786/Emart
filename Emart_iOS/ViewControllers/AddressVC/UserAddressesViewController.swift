//
//  UserAddressesViewController.swift
//  oye baryani
//
//  Created by Apple on 23/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD
class UserAddressesViewController: UIViewController {
    var showAddressData:ShowAddressAPI?
    
    @IBOutlet weak var addressesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ShowAddresses()
    }
    
    @IBAction func addAddressButtonTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func PopNavigationController(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func ShowAddresses(){
        
        guard let user = UserStateHolder.loggedInUser else {
            return
        }
        
        guard let url = URL(string: URLPath.ShowAddresses) else {
            print("URL Error")
            return
        }
       
        let parameter = ["email":user.email ?? ""]
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Loading")
        EMartAPIManager.shared.ShowAddress(url: url, parameter: parameter) {[self] (ShowAddressData, error) in
            SVProgressHUD.dismiss()
            if (error == false){
                let address = ShowAddressData
                showAddressData = address
                showAddressData?.records = address!.records?.sorted(by:{$0.id! > $1.id!})
                addressesTableView.reloadData()
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Address not Found")
            }
        }
        
        
    }
    
    
    
}
extension UserAddressesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAddressData?.records?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserAddressesTableViewCell", for: indexPath) as!
            UserAddressesTableViewCell
        cell.SetData(record: (showAddressData?.records?[indexPath.row])!)
        cell.removeAddressesButton.tag = indexPath.row
        cell.removeAddressesButton.addTarget(self, action: #selector(removeAddresses(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func removeAddresses(sender:UIButton){
        if let record = showAddressData?.records?[sender.tag]{
            if let address_id = record.id{
                removeAddress(address_id: address_id
                              , completion: {removed in
                                
                                if removed == true{
                                    self.ShowAddresses()
                                }
                              }
                )
            }
            
        }
        
    }
    func removeAddress(address_id:String,completion:@escaping ((Bool)->Void)){
        guard let addressid = Int(address_id),
              let user = UserStateHolder.loggedInUser else{
            return
        }
        
        let parameter:[String:Any] = ["email": user.email ?? "","id": addressid]
        
        guard let url = URL(string: URLPath.RemoveAddress) else {
            print("URL Error")
            return
        }
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Loading")
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parameter) { (errorMessage, error) in
            SVProgressHUD.dismiss()
            if error == false{
                completion(true)
            }
            else{
                completion(false);
                UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
        }
    }
}
