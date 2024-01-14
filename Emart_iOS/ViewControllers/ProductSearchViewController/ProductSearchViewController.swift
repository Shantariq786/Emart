//
//  SearchViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 06/01/2022.
//

import UIKit
import SVProgressHUD

class ProductSearchViewController: UIViewController {

    @IBOutlet weak var foodBtn:UIButton!
    @IBOutlet weak var resturantBtn:UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var currentIndex = 0
    var seachText = ""
    var selectedVariationIndex = 0
    var cartSelectedIndex = -1
    var resturantProducts : RestaurantProductResult? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDesign()
        fetchFoodItems()
    }
    func setDesign(){
        if currentIndex == 0{
            foodBtn.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            foodBtn.setTitleColor(UIColor.white, for: .normal)
            
            resturantBtn.backgroundColor = UIColor.white
            resturantBtn.setTitleColor(UIColor.black, for: .normal)
        }else{
            
            foodBtn.backgroundColor = UIColor.white
            foodBtn.setTitleColor(UIColor.black, for: .normal)
            
            resturantBtn.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            resturantBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func fetchFoodItems(){
        guard let user = UserStateHolder.loggedInUser else {
            return
        }
        let parameter = ["email": user.email!,
                         "title": "pizza"] as [String : Any]
        
        APIService.sharedInstance.getSearchResults(parameters: parameter) { (resturantProducts) -> (Void) in
            self.resturantProducts = resturantProducts
            self.tableview.reloadData()
            
        } failure: { (error) -> (Void) in
            
        }

    }
    
    func fetchVendors(){
        
    }
    
    
    @IBAction func goBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func foodBtnTapped(_ sender:UIButton){
        currentIndex = 0
        setDesign()
        
    }
    
    @IBAction func resturantBtnTapped(_ sender:UIButton){
        currentIndex = 1
        setDesign()
    }
    
    
}

