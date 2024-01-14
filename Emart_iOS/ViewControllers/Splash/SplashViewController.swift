//
//  SplashViewController.swift
//  Batch4App
//
//  Created by Muhammad Yousaf on 20/04/2021.
//


import UIKit
import Lottie

class SplashViewController: BaseViewController{

    @IBOutlet weak var backGroundAnimation:AnimationView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setUpAnimation(animationView: backGroundAnimation, isScaleToFit: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // move the next screen

            if self.isAppAlreadyLaunchedOnce() == true{
                let rootVC = UIStoryboard.home.instantiateViewController(withIdentifier: "WelcomeBackViewController") as! WelcomeBackViewController
                self.navigationController?.pushViewController(rootVC, animated: true)
            }else{

                self.navigationController?.setNavigationBarHidden(true, animated: true)
                let rootVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SliderViewController")
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
        }

    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func setUpAnimation(animationView:AnimationView,animationSpeed :CGFloat = 0.5 , isScaleToFit:Bool ){
        animationView.loopMode = .loop
        animationView.animationSpeed = animationSpeed
        //animationView.contentMode = .scaleAspectFill
        
        animationView.play()
    }
}
