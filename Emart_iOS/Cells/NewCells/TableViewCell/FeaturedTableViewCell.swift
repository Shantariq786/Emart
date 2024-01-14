//
//  FeaturedTableViewCell.swift
//  EMart
//
//  Created by Muhammad Yousaf on 05/07/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {
    

    @IBOutlet var collectionView: UICollectionView!
//    var mainCategoryRecords:[showMainCategoryRecords]?
    var records : [showRestaurantsRecords]?
    
    var vc = UIViewController()
    var selectedIndexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 8)
        self.contentView.dropShadowAllSides()
        self.layoutIfNeeded()
    }
    func setupData(records: [showRestaurantsRecords]?) {
        self.records = records
        self.collectionView.reloadData()
    }
    
}
extension FeaturedTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.records?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
        cell.indepath = indexPath
        cell.heatButtonProtocol = self
        cell.setData(record: self.records?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
//        print("clicked")

        let StoryBoard = UIStoryboard(name: "Resturant", bundle: nil)
        let Nextvc = StoryBoard.instantiateViewController(withIdentifier: "ResturantDetailViewController") as! ResturantDetailViewController
        Nextvc.resturantData = self.records?[indexPath.row]
        Nextvc.indexPath = indexPath
        Nextvc.resturantDetailProtocol = self
        vc.navigationController?.pushViewController(Nextvc,animated: true)
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = collectionView.bounds.width * 0.8
        return CGSize(width: yourWidth, height: 230)
    }
    
}


extension FeaturedTableViewCell: HeatButtonProtocol{
    
    func heartButtonPressed(indepath: IndexPath) {
        selectedIndexPath = indepath
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            let nextVc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            nextVc.loginProtocol = self
            vc.navigationController?.pushViewController(nextVc, animated: true)
        }else{
            loginDoneTapped()
        }
    }
    
    
}
    
    

extension FeaturedTableViewCell:ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath: IndexPath, resturantData: showRestaurantsRecords) {
        self.records?[indexPath.row] = resturantData
        self.collectionView.reloadItems(at: [indexPath])
        
    }
    
    
}




//MARK: -               LOGIN PROTOCOL

extension FeaturedTableViewCell:LoginProtocol{
    func loginDoneTapped() {
        addToFavourites()
    }
    
    func addToFavourites(){
        let currentFavStat = Int((records?[selectedIndexPath.row].is_fav)!)
        if currentFavStat == 0{
            // make it favourite
            records?[selectedIndexPath.row].is_fav = "1"
        }else{
            //remove if from favourite
            records?[selectedIndexPath.row].is_fav = "0"
        }
        
        collectionView.reloadItems(at: [selectedIndexPath])
        guard let isLike = records![selectedIndexPath.row].is_fav , let vendor_email = records![selectedIndexPath.row].email else{return}
        guard let user = UserStateHolder.loggedInUser else{return}
        
        let parameters =  ["islike" : isLike , "vendor_email":vendor_email , "user_email":user.email]
        print(parameters)
        APIService.sharedInstance.updateFav(parameters: parameters as [String : Any]) { favouriteRes in
            if favouriteRes.error == false{
                print(favouriteRes.error_msg ?? "")
            }
        } failure: { (error) -> (Void) in
            
        }
    }
    
    
}
