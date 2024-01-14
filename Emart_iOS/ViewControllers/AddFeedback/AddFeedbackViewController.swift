//
//  AddFeedbackViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 31/07/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Cosmos

class AddFeedbackViewController: UIViewController {
    
    
    @IBOutlet weak var ratingView:CosmosView!
    @IBOutlet weak var commentTextView:UITextView!
    @IBOutlet weak var feedbackImageView:UIImageView!
    
    
    var restaurantId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ratingView.didFinishTouchingCosmos = { rating in
            
            if rating < 2 || rating == 2 {
                //this is bad
                self.feedbackImageView.image = UIImage(named: "ic_worst_review")
                return
            }
            
            if rating < 4 || rating == 4 {
                //this is okay
                self.feedbackImageView.image = UIImage(named: "ic_good_review")
                return
            }
            
            if rating > 4 {
                //wow
                self.feedbackImageView.image = UIImage(named: "ic_excellent_review")
                return
            }
            
            
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitFeedback(){
        
        
        guard let email = UserStateHolder.loggedInUser?.email else {
            return
        }
        
        let parameters = ["restaurant_id":self.restaurantId,
                          "rating" : self.ratingView.rating,
                          "comment":self.commentTextView.text ?? "",
                          "user_email":email] as [String : Any]
        
        APIService.sharedInstance.genericAPIResponse(url: URLPath.AddVendorReview, parameters: parameters) { (responseModel) -> (Void) in
            var title = ""
            var message = ""
            if let error = responseModel.error, let msg = responseModel.errorMsg{
                if error{
                    title = "Error"
                    message = AlertTitle.ALERT_WEBSERVICE_ERROR
                }else{
                    title = "Success"
                    message = msg
                }
            }else{
                title = "Error"
                message = AlertTitle.ALERT_WEBSERVICE_ERROR
            }
            UIViewController.showAlert(inViewController: self, title: title, message: message) {
                self.navigationController?.popViewController(animated: true)
            }
        } failure: { (error) -> (Void) in
            UIViewController.showAlert(inViewController: self, title: "Error", message: error)
        }

        
    }

}
