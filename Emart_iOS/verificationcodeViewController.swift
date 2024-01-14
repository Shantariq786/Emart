//
//  verificationcodeViewController.swift
//  oye baryani
//
//  Created by Apple on 04/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class verificationcodeViewController: UIViewController {

    @IBOutlet weak var signup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        signup.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "promotionsViewController") as! promotionsViewController
        self.navigationController?.pushViewController(vc, animated: true)

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
