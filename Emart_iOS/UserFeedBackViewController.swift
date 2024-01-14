//
//  UserFeedBackViewController.swift
//  oye baryani
//
//  Created by Apple on 18/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
class UserFeedBackViewController: UIViewController {
    @IBOutlet weak var feedBackTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func PopNavigationController(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SubmitButton(_ sender: UIButton)
    {
        
        guard let user = UserStateHolder.loggedInUser,
              let feedBacktext = feedBackTextField.text else {
            return
        }
        
        if feedBacktext == "" {
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Please Enter Your Message")
        }else{
            let parameter =  ["message":feedBacktext,"name":user.name ?? "","email": user.email ?? ""] as [String : Any]
            guard let url = URL(string: URLPath.Feedback) else {
                print("URL Error")
                return
            }
            EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parameter) { (errorMessage, error) in
                if error == false
                {
                    UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
                    
                }
                else{
                    UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
                }
            }
        }
    }
}
