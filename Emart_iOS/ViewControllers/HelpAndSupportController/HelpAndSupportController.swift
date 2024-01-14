//
//  HelpAndSupportController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 08/12/2021.
//

import UIKit
import MessageUI

class HelpAndSupportController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func emailBtnTapped(_ sender: Any) {
        
        let composeVC = MFMailComposeViewController()
           composeVC.mailComposeDelegate = self

           // Configure the fields of the interface.
           composeVC.setToRecipients(["mail.edelivero@gmail.com"])
           composeVC.setSubject("Need Help")
           //composeVC.setMessageBody("Message content.", isHTML: false)

           // Present the view controller modally.
           self.present(composeVC, animated: true, completion: nil)
        
    }
    @IBAction func whatsappBtnTapped(_ sender: Any) {
        
        let phoneNumber =  "+923128141987" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
        
    }
    
    @IBAction func phoneBtnTapped(_ sender: Any) {
        let phoneNumber = "0544225173"
        let numberUrl = URL(string: "tel://\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.

        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
       }
    
}
