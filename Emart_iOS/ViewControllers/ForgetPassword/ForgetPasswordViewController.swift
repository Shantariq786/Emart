//
//  ForgetPasswordViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 16/11/2021.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
    
}
