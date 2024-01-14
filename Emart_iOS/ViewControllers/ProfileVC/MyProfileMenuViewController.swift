//
//  MyProfileViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/3/21.
//  Copyright © 2021 Apple. All rights reserved.

//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import StoreKit
import Kingfisher
class MyProfileMenuViewController: UIViewController {

    var mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    var window: UIWindow?
    var storyBoard :UIStoryboard?
    var nnavigationController : UINavigationController?
    var images:[UIImage] = [UIImage(named: "userEdit")!,#imageLiteral(resourceName: "ic_orders"),#imageLiteral(resourceName: "ic_home"),UIImage(named: "coupon")!,#imageLiteral(resourceName: "ic_promotions"),#imageLiteral(resourceName: "ic_feedback"),#imageLiteral(resourceName: "ic_rate_us"),#imageLiteral(resourceName: "ic_refer"),#imageLiteral(resourceName: "ic_support"),#imageLiteral(resourceName: "ic_logout")]
    var nameArray = ["Edit Profile","My Orders","My Address","My Vouchers","Promotions","Feedback","Rate Us","Refer a friend","Help & Support","Logout"]
    
    var user:User?
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var logInLabel:UILabel!
    @IBOutlet weak var logInBtn:UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userProfileStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = UserStateHolder.loggedInUser ?? nil
        print("user ",user as Any)
        
        if user == nil {
            userName.isHidden = true
            userEmail.isHidden = true
            return
        }
        
        userName.isHidden = false
        userEmail.isHidden = false
        
        logInLabel.isHidden = true
        logInBtn.isHidden = true
        
        userName.text = user!.name
        userEmail.text = user!.email
        
        
        let fullSrtUrl = "\(BASEURL.imageUrl)\(user!.image ?? "")"
        print("fullSrtUrl \(fullSrtUrl)")
        let url = URL(string: fullSrtUrl)
        userImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: nil, progressBlock: nil, completionHandler: nil)
        
        tableView.reloadData()
        
    }
    
    @IBAction func logInBtnTapped(_ sender: UIButton) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
        vc.loginProtocol = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func LogoutProcess() {
        AccessToken.current = nil
        GIDSignIn.sharedInstance().signOut()
        UserStateHolder.resetUserState()
        
        if window == nil{
            window = UIWindow(frame: UIScreen.main.bounds)
            
        }
        if nnavigationController == nil{
           nnavigationController = UINavigationController()
        }
        if storyBoard == nil{
           storyBoard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is WelcomeBackViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
        
        
        setFCMToken(fcmToken:"")
        
        
    }
    
    func setFCMToken(fcmToken:String){
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        let parameters =  ["email" : email,
                           "token":fcmToken]
        
        APIService.sharedInstance.setFirebaseToken(parameters: parameters) { (tokenDetail) -> (Void) in
            if tokenDetail.error == false {
                print("token Detail \(tokenDetail.error_msg!)")
            }
        } failure: { (error) -> (Void) in
            
        }
        
    }

}
extension MyProfileMenuViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMenuTableViewCell") as! ProfileMenuTableViewCell
        cell.ItemImage.image = images[indexPath.row].maskWithColor(color: UIColor(named: "AppDarkGrayColor")!)
        cell.nameLabel.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if user != nil{
            return 60
        }else{
            return getHeightForCell(indexPath: indexPath)
        }
        
    }
    
    func getHeightForCell(indexPath: IndexPath)->CGFloat{
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 9{
            return 0
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UserProfileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = MyOrdersViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:  "UserAddressesViewController" ) as! UserAddressesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 {
            let vc = VouchersViewController()
            vc.isFromSetting = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4 {
            let vc = mainStoryBoard.instantiateViewController(withIdentifier:  "promotionsViewController" ) as! promotionsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5 {
            let vc = mainStoryBoard.instantiateViewController(withIdentifier:  "UserFeedBackViewController" ) as! UserFeedBackViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 6 {
            //rate us
            rateApp()
        }
        else if indexPath.row == 7 {
            
            if let websiteURL = URL(string: "https://apps.apple.com/us/app/edelivero-food-delivery/id1610987861") {
               let objectsToShare = ["Check out EMart app, I use it from anywhere in the world to stay in touch with my Customer", websiteURL] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
               if let popoverController = activityVC.popoverPresentationController {
                  popoverController.sourceView = self.view
                  popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
               }
               present(activityVC, animated: true)
            }
            
            
        }
        else if indexPath.row == 8 {
            
            let vc = HelpAndSupportController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 9 {
            LogoutProcess()
        }
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}


//MARK: -               LOGIN PROTOCOL

extension MyProfileMenuViewController:LoginProtocol{
    func loginDoneTapped() {
        user = UserStateHolder.loggedInUser ?? nil
        
        userName.isHidden = false
        userEmail.isHidden = false
        
        logInLabel.isHidden = true
        logInBtn.isHidden = true
        
        tableView.reloadData()
    }
}

