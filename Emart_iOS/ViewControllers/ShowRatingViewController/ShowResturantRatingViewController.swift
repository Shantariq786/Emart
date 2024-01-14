//
//  ShowResturantRatingViewController.swift
//  Emart_iOS
//
//  Created by Hexacrew on 10/02/2022.
//

import UIKit
import Cosmos

class ShowResturantRatingViewController: UIViewController {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    
    @IBOutlet weak var tableview: UITableView!
    var records:[RatingRecord]?
    var resturantEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "RatingCellTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingCellTableViewCell")
        
        getRating()
    }
    
    func getRating(){
        
        let params: [String: Any] = ["vendor_email":resturantEmail]
        APIService.sharedInstance.fetchRatings(parameters: params) {[self] model in
            if model.error == false{
                records = model.records
                let rating = getTotalRating()
                starsView.rating = rating
                tableview.reloadData()
            }
        } failure: { (error) -> (Void) in

        }
    }
    
    func getTotalRating()->Double{
        var rating:Double = 0
        if let records = records{
            for item in records{
                rating = rating + Double(item.rating ?? "0")!
            }
            return rating/Double(records.count)
        }else{
            return 0
        }
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension ShowResturantRatingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCellTableViewCell") as! RatingCellTableViewCell
        cell.setdata(record: records?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
