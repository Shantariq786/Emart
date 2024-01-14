//
//  ViewAllViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 27/01/2022.
//

import UIKit

class ViewAllViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var resturants = [showRestaurantsRecords]()
    var screenTitle = ""
    var selectedIndexPath:IndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = screenTitle
        tableView.register(UINib(nibName: "RestuarantsTableViewCell", bundle: nil), forCellReuseIdentifier: "RestuarantsTableViewCell")
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//MARK: -                          COLLECTIONVIEW PROTOCOLS
extension ViewAllViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarantsTableViewCell") as! RestuarantsTableViewCell
        cell.setData(record: resturants[indexPath.row], indepath: indexPath)
        cell.allResturantHeatButtonProtocol = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped at in home \(indexPath)")
        
       
            let StoryBoard = UIStoryboard(name: "Resturant", bundle: nil)
            let Nextvc = StoryBoard.instantiateViewController(withIdentifier: "ResturantDetailViewController") as! ResturantDetailViewController
            Nextvc.resturantData = resturants[indexPath.row]
            Nextvc.indexPath = indexPath
            Nextvc.resturantDetailProtocol = self
            self.navigationController?.pushViewController(Nextvc,animated: true)
        
    }
   
}




//MARK: -                       CUSTOM PROTOCOLS

extension ViewAllViewController:AllResturantHeatButtonProtocol{
    func allResturantHeartButtonPressed(indepath: IndexPath) {
        
        selectedIndexPath = indepath
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            loginDoneTapped()
        }
        
        
    }
    
}


//MARK: -
extension ViewAllViewController:ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath: IndexPath, resturantData: showRestaurantsRecords) {
        self.resturants[indexPath.row] = resturantData
        
    }
    
    
}


extension ViewAllViewController:LoginProtocol{
    func loginDoneTapped() {
        
        let currentFavStat = Int((resturants[selectedIndexPath.row].is_fav)!)
        if currentFavStat == 0{
            // make it favourite
            resturants[selectedIndexPath.row].is_fav = "1"
        }else{
            //remove if from favourite
            resturants[selectedIndexPath.row].is_fav = "0"
        }
        
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
        
        
        //update on server
        
        guard let isLike = resturants[selectedIndexPath.row].is_fav , let vendor_email = resturants[selectedIndexPath.row].email else{return}
        guard let user = UserStateHolder.loggedInUser else{return}
        
        let parameters =  ["islike" : isLike , "vendor_email":vendor_email , "user_email":user.email]
        print(parameters)
        APIService.sharedInstance.updateFav(parameters: parameters as [String : Any]) { favouriteRes in
            if favouriteRes.error == false{
                print(favouriteRes.error_msg as Any)
            }
        } failure: { (error) -> (Void) in
            
        }
    }
    
    
}
