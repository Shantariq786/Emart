//
//  WelcomeViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/8/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var onboardingContainer: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBAction func skipOnboarding(_ sender: UIButton) {
        sender.removeFromSuperview()
        onboardingContainer.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
