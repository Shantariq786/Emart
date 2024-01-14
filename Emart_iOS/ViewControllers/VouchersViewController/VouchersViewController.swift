//
//  VouchersViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 10/02/2022.
//

import UIKit
protocol CouponProtocol{
    func couponSelected(value:String)
}

class VouchersViewController: UIViewController {

    @IBOutlet weak var textfieldView: UIView!
    @IBOutlet weak var textfieldViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var records:[VoucherRecord]?
    
    var couponProtocol:CouponProtocol!
    
    var isFromSetting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "VoucherTableViewCell", bundle: nil), forCellReuseIdentifier: "VoucherTableViewCell")
        getVouchers()
        setUpScreen()
    }
    
    func setUpScreen(){
        if isFromSetting == true{
            textfieldViewHeight.constant = 0
            textfieldView.isHidden = true
        }
    }
    
    func getVouchers(){
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        let params: [String: Any] = ["user_email":email]
        APIService.sharedInstance.fetchVouchers(parameters: params) {[self] model in
            if model.error == false{
                records = model.records
                tableview.reloadData()
            }
        } failure: { (error) -> (Void) in

        }
    }

    @IBAction func applyBtnTapped(_ sender: Any) {
        guard let value = couponTextField.text else{
            self.showToast(message: "Textfield cannot be empty", font: .systemFont(ofSize: 12.0))
            return
        }
        couponProtocol.couponSelected(value: value)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension VouchersViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoucherTableViewCell") as! VoucherTableViewCell
        cell.setData(indexpath: indexPath, record: records?[indexPath.row])
        cell.selectionStyle = .none
        cell.voucherProtocol = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
}


extension VouchersViewController:VoucherProtocol{
    func redeemBtnTapped(indexpath: IndexPath) {
        guard let text = records?[indexpath.row].coupon_key else {return}
        if isFromSetting == true{
            UIPasteboard.general.string = text
            self.showToast(message: "Code Copied \(text)", font: .systemFont(ofSize: 12.0))
        }else{
            couponProtocol.couponSelected(value: text)
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    
}
