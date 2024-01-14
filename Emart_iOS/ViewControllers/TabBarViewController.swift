//
//  TabBarViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/3/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import SOTabBar
class TabBarViewController: SOTabBarController {
    var HomeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
    var CartStoryBoard = UIStoryboard(name: "Cart", bundle: nil)
    var ProfileStoryBoard = UIStoryboard(name: "Porfile", bundle: nil)
    var isOrderFoodSelected = false
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = UIColor(named: "AppPrimaryBlueColor")!
        
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let homeStoryboard:UIViewController!
        
        if isOrderFoodSelected{
            // move to home screen
            homeStoryboard = HomeStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
        }else{
            //move to shop screen
            homeStoryboard = HomeStoryBoard.instantiateViewController(withIdentifier: "ShopHomeController")
        }
        
       
        let notificationStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")
        let cartStoryboard = CartStoryBoard.instantiateViewController(withIdentifier: "CartViewController")
        let heartStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoritesViewController")
        let profileStoryboard = ProfileStoryBoard.instantiateViewController(withIdentifier: "MyProfileMenuViewController")
       
        
        homeStoryboard.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "house"), selectedImage: UIImage(named: "selected-house")?.maskWithColor(color: UIColor(named: "AppSecondaryColor")!))
        notificationStoryboard.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notification"), selectedImage: UIImage(named: "selected-notification")?.maskWithColor(color: UIColor(named: "AppSecondaryColor")!))
        cartStoryboard.tabBarItem = UITabBarItem(title: "", image:UIImage(named: "shopping-cart-1"), selectedImage: UIImage(named: "selected-shopping-cart")?.maskWithColor(color: UIColor(named: "AppSecondaryColor")!))
        heartStoryboard.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "like"), selectedImage: UIImage(named: "selected-like")?.maskWithColor(color: UIColor(named: "AppSecondaryColor")!))
        profileStoryboard.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "user"), selectedImage: UIImage(named: "selected-user")?.maskWithColor(color: UIColor(named: "AppSecondaryColor")!))
       
           
        viewControllers = [homeStoryboard, notificationStoryboard,cartStoryboard,heartStoryboard,profileStoryboard]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfOrderIsPlaced()
    }
    
    func checkIfOrderIsPlaced(){
        print("orderPlace ",UserDefaults.standard.bool(forKey: "orderPlace"))
        let orderPlace = UserDefaults.standard.bool(forKey: "orderPlace")
//        self.selectedIndex = 4
//        TabBarViewController.selectedIndex = 1
        //self.selectedIndex = 1
//        if orderPlace == true{
//            self.selectedIndex = 1
//
//        }
    }
    
}

extension TabBarViewController: SOTabBarControllerDelegate {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController) {
        print(viewController.tabBarItem.title ?? "")
        print("selectedIndex ",tabBarController.selectedIndex)
    }
}


