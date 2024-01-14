//
//  OrderPlacedViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 15/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class OrderPlacedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func DoneButton(_ sender: UIButton){
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is TabBarViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
               UserDefaults.standard.set(true, forKey: "orderPlace")
            }
        }

    }

}
