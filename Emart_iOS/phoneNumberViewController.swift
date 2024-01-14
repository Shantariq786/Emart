//
//  phoneNumberViewController.swift
//  oye baryani
//
//  Created by Apple on 04/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class phoneNumberViewController: UIViewController {

   
    @IBOutlet weak var sendcode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendcode.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendcode(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
