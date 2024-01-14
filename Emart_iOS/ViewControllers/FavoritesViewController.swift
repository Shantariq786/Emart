//
//  FavoritesViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/17/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import CoreMedia

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favouriteTableView: UITableView!
    @IBOutlet weak var noFavouritesView: UIView!
    
    @IBOutlet weak var createAccountView: UIView!
    
    var obj_showRestaurants:showRestaurantsAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteTableView.register(UINib(nibName: "RestuarantsTableViewCell", bundle: nil), forCellReuseIdentifier: "RestuarantsTableViewCell")
        favouriteTableView.tableFooterView = UIView()
        noFavouritesView.isHidden = false
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAccountView.isHidden = true
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            createAccountView.isHidden = false
        }else{
            getFavourites()
        }
        
    }
    
    @IBAction func createAccountBtnTapped(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
        vc.loginProtocol = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getFavourites(){
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        
        let paramater :[String:Any] = ["user_email": email]
        APIService.sharedInstance.showUserFavourites(parameter: paramater) {[self] data, error in
            if data != nil {
                
                if data?.records?.count == nil{
                    noFavouritesView.isHidden = false
                }else{
                    noFavouritesView.isHidden = true
                    self.obj_showRestaurants = data
                    self.favouriteTableView.reloadData()
                }
                
            }
        }

    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return obj_showRestaurants?.records?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarantsTableViewCell") as! RestuarantsTableViewCell
        cell.setData(record: self.obj_showRestaurants?.records![indexPath.row], indepath: indexPath)
        cell.allResturantHeatButtonProtocol = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let StoryBoard = UIStoryboard(name: "Resturant", bundle: nil)
        let Nextvc = StoryBoard.instantiateViewController(withIdentifier: "ResturantDetailViewController") as! ResturantDetailViewController
        Nextvc.indexPath = indexPath
        Nextvc.resturantDetailProtocol = self
        Nextvc.resturantData = self.obj_showRestaurants?.records?[indexPath.row]
        self.navigationController?.pushViewController(Nextvc,animated: true)
        
    }
    
    func makeObject(){
        
    }
    
}

extension FavoritesViewController:AllResturantHeatButtonProtocol{
    func allResturantHeartButtonPressed(indepath: IndexPath) {
        
        guard let vendor_email = self.obj_showRestaurants?.records?[indepath.row].email else{return}
        guard let user = UserStateHolder.loggedInUser else{return}

        let parameters =  ["islike" : "0" , "vendor_email":vendor_email , "user_email":user.email]
        print(parameters)
        APIService.sharedInstance.updateFav(parameters: parameters as [String : Any]) { favouriteRes in
            if favouriteRes.error == false{

                //update the user interface
                self.self.obj_showRestaurants?.records?.remove(at: indepath.row)
                self.favouriteTableView.deleteRows(at: [indepath], with: .left)

                print(favouriteRes.error_msg ?? "")
            }
        } failure: { (error) -> (Void) in

        }

        
    }
    
    

}


extension FavoritesViewController:ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath: IndexPath, resturantData: showRestaurantsRecords) {
        print("call from favourite screen")
    }
    
    
}


extension FavoritesViewController:LoginProtocol{
    func loginDoneTapped() {
        createAccountView.isHidden = true
    }
    
    
}
