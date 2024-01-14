//
//  LOGINViewController.swift
//  oye baryani
//
//  Created by Apple on 03/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//
// 1. get current time
//2. oder place time
//3. add 45min in point 2
//4. minus current time.
// 15 , 5 , 15

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import SVProgressHUD

protocol LoginProtocol{
    func loginDoneTapped()
}

struct registrationdata{
    var name:String?
    var email:String?
    var image:URL?
    var phonenumber:Int?
    var passwordType:String?
    var password:String?
}

class LOGINViewController: BaseViewController{
    
    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var gmailSignButton: UIButton!
    
    var obj = registrationdata()
    var loginProtocol:LoginProtocol!
    let parameters = ["fields": "email,picture.type(large),name,gender,age_range,cover,timezone,verified,updated_time,education,religion,friends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView(){
        //imagee.layer.cornerRadius = 5
        facebook.layer.cornerRadius = facebook.bounds.height/6
        facebook.layer.borderWidth = 1
        facebook.layer.borderColor = #colorLiteral(red: 1, green: 0.8063359499, blue: 0.07583252777, alpha: 0.8241384846)
        gmailSignButton.layer.cornerRadius = gmailSignButton.bounds.height/6
        gmailSignButton.layer.borderWidth = 1
        gmailSignButton.layer.borderColor = #colorLiteral(red: 1, green: 0.8063359499, blue: 0.07583252777, alpha: 0.8241384846)
    }
    
    @IBAction func goBackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func GmailLogin (_ sender: Any) {
        
        if Connectivity.isConnectedToInternet(){
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().presentingViewController = self
            GIDSignIn.sharedInstance().signIn()

        }
        else{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "No internet Connection")
        }
    }
    
    
    
   
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
        
        let loginManager: LoginManager = LoginManager()
        loginManager.logOut()
    }
    
    
    @IBAction func FacebookLoginBtn(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet(){
            FacebookLogin()
        }
        else{
            UIViewController.self.showAlertWithoutButton(inViewController: self, message: "No internet Connection")
        }
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton){
        passwordTextField.isSecureTextEntry = false
        guard let email = userEmailTextField.text,let password = passwordTextField.text else {
            return
        }
        
        print("emaillll \(email)  passwordddd \(password)")
        
        if Connectivity.isConnectedToInternet() {
            self.loginWithEmailAndPassword(email:email, password: password,useriD:password,type:"manual")
        }
        else{
            UIAlertController.showAlertWithoutButton(inViewController: self, message: "No Internet Connection")
        }
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func signUpButtontapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.loginProtocol = loginProtocol
        
    }
    
    @IBAction func ForgetPasswordBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

 // Facebook
extension LOGINViewController{
    func fetchProfile() {
        GraphRequest(graphPath: "/me", parameters: parameters).start{ (connection,result,error)-> Void in
            
            if error != nil {   // Error occured while logging in
                // handle error
                print(error!)
                return
            }
            print(result!)
            let data = result as! [String: AnyObject]
            let userid = data["id"] as? String
            self.obj.password = self.getsubstring(userID: userid!)
            self.obj.name = data["name"] as? String
            self.obj.email = data["email"] as? String
            self.obj.passwordType = "facebook"
            if let pictureinfo = data["picture"] as? NSDictionary{
                if  let picturedata =  pictureinfo["data"] as? NSDictionary{
                    if let url = picturedata["url"] as? String {
                        print(url)
                        self.obj.image = URL(string: url)                    }
                }
            }
            if Connectivity.isConnectedToInternet(){
                self.LoginAPICheck(email:self.obj.email ?? "",useriD:userid!,type:"facebook")
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "No Internet Connection")
            }
        }
    }
    
    func FacebookLogin(){
        if AccessToken.current != nil {
            fetchProfile()
        }
        else {
            
            let loginManager = LoginManager()
            loginManager.logIn(permissions: ["email","public_profile","user_friends"], from: self, handler: { (loginResults: LoginManagerLoginResult?, error: Error?) -> Void in
                if !(loginResults?.isCancelled)! {
                    self.fetchProfile()
                } else {
                    print("LogIn Canceled By User")
                    print(error.debugDescription)
                }
            })
        }
    }
}

//ViewControllers
extension LOGINViewController{
    
    func getsubstring(userID:String) -> String{
        let start = String.Index(utf16Offset: 2, in: userID)
        let end = String.Index(utf16Offset: 6, in: userID)
        let substring = String(userID[start..<end])
        return substring
    }
    
    func getHomeViewController(){
        loginProtocol.loginDoneTapped()
        self.navigationController?.popViewController(animated: true)
      
    }
    func getRegistrationController(){
        
        if #available(iOS 13, *) {
            let view = self.storyboard?.instantiateViewController(identifier: "RegisterUserViewController") as! RegisterUserViewController
            view.ob = self.obj
            self.navigationController?.pushViewController(view, animated: true)
        }
        else{
            let view = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
            view.ob = self.obj
            self.navigationController?.pushViewController(view, animated: true)
        }
        
    }
    func getRiderController(){
        
        if #available(iOS 13, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "ShowAllOrderToRiderViewController") as! ShowAllOrderToRiderViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShowAllOrderToRiderViewController") as! ShowAllOrderToRiderViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
        
}


extension LOGINViewController {
    
    func LoginAPICheck(email:String,useriD:String,type:String) {
        print("email \(email)  passw")
        let parameters:[String:Any] = ["email":email,"password":"12345","password_type":type]
        
        APIService.sharedInstance.registerLoginUser(url: URLPath.LoginUser, parameters: parameters) { (userResult) -> (Void) in
            
            if userResult.user == nil{
                // create user new account
            }else{
                // login the user
                
                UserStateHolder.isUserLoggedIn = true
                UserStateHolder.loggedInUser = userResult.user
                self.getHomeViewController()
                
            }
            
            
            
            
        } failure: { (error) -> (Void) in
            
        }
    }
    
    func createUserAccountForGoogleAndFacebook(){
        
        let random = generateRandomDigits(6)
        let parameters = ["name":userNameTextField.text ?? "","email":userEmailTextField.text ?? "","phone": "","password":password,"password_type": "manual","myref":random,"ref":"","image":"asad.png"]

        APIService.sharedInstance.registerLoginUser(url: URLPath.RegisterUser, parameters: parameters ?? ["":""]) { (userResult) -> (Void) in
            
            UserStateHolder.isUserLoggedIn = true
            UserStateHolder.loggedInUser = userResult.user
            
            self.homeController()
            
        } failure: { (error) -> (Void) in
            
        }

        
    }
    
    
    func loginWithEmailAndPassword(email:String,password:String,useriD:String,type:String){
        print("email \(email)  password \(password)")
        let parameters:[String:Any] = ["email":email,"password":password,"password_type":type]
        
        APIService.sharedInstance.registerLoginUser(url: URLPath.LoginUser, parameters: parameters) { (userResult) -> (Void) in
            
            if userResult.error == true{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Invalid credentials")
                return
            }
            
            UserStateHolder.isUserLoggedIn = true
            UserStateHolder.loggedInUser = userResult.user
            self.getHomeViewController()
            
        } failure: { (error) -> (Void) in
            
        }
    }
}


//Google
extension LOGINViewController:GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
        if error != nil {
            print("\(error.localizedDescription)")
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            return
        }
        
        if (GIDSignIn.sharedInstance().hasPreviousSignIn()){
            //print(user.userID)
            let userId = user.userID
            obj.password = getsubstring(userID: userId!)
            obj.name = user.profile?.name
            obj.email = user.profile?.email
            obj.image = user.profile?.imageURL(withDimension: 50)
            obj.passwordType = "google"
            if Connectivity.isConnectedToInternet(){
                LoginAPICheck(email:obj.email ?? "",useriD:userId!,type:"google")
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "No Internet Connection")
            }
        } else {
            if let error = error {
                print("\(error.localizedDescription)")
                // [START_EXCLUDE silent]
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
                // [END_EXCLUDE]
            } else {
                
                let userId = user.userID
                obj.password = getsubstring(userID: userId!)
                obj.name = user.profile?.name
                obj.email = user.profile?.email
                obj.image = user.profile?.imageURL(withDimension: 50)
                obj.passwordType = "google"
                LoginAPICheck(email:obj.email ?? "",useriD:userId!,type:"google")
                
            }
        }
        
    }
    
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
    
}
