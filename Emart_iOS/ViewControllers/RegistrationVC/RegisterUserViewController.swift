//
//  RegisterUserViewController.swift
//  oye baryani
//
//  Created by Apple on 17/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class RegisterUserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var ob = registrationdata()
    
    var myref:String?
    var image:UIImage?
    var ref:String?
    var parameters:[String:Any]? = nil
    var imagename:String = ""
    
    var loginProtocol:LoginProtocol!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //placeholder_user.png
        self.userEmailTextField.text = ob.email
        self.userNameTextField.text = ob.name
        self.passwordTextField.text = ob.password

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    @IBAction func loginButtontapped(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
    @IBAction func RegisterUser(_ sender: UIButton) {
        if passwordTextField.text != "" && userNameTextField.text != ""{
            RegisterUser()
        }
        else{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Please Enter Phone No and Name")
        }
    }
}
extension RegisterUserViewController {
    
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    func RegisterUser(){
        let random = generateRandomDigits(6)
        
        passwordTextField.isSecureTextEntry = false
        let password:String = passwordTextField.text ?? ""
        
        print(password)
        
        if (ob.email == "" || ob.name == "" || ob.password == "" || ob.passwordType == "" || ob.phonenumber == nil) {
            parameters =  ["name":userNameTextField.text ?? "","email":userEmailTextField.text ?? "","phone": "","password":password,"password_type": "manual","myref":random,"ref":"","image":"asad.png"]
        }
        else {
            parameters =  ["name":ob.name ?? "","email":ob.email ?? "","phone": "","password":"12345","password_type":ob.passwordType ?? "","myref":random,"ref":"","image":"asad.png"]
        }
        
        passwordTextField.isSecureTextEntry = true
        
        APIService.sharedInstance.registerLoginUser(url: URLPath.RegisterUser, parameters: parameters ?? ["":""]) { (userResult) -> (Void) in
            
            UserStateHolder.isUserLoggedIn = true
            UserStateHolder.loggedInUser = userResult.user
            
            self.homeController()
            
        } failure: { (error) -> (Void) in
            
        }

        
    }
    
    func homeController(){
        loginProtocol.loginDoneTapped()
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
       
    }
}

