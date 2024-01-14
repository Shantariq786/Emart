//
//  SideMenuBaseViewController.swift
//  oye baryani
//
//  Created by Apple on 18/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
struct Menuoption {
    var optionname:String
    var optionImage:UIImage
}
class SideMenuBaseViewController: UIViewController{}
//{
//
//   @IBOutlet weak var btnCloseMenuOverLay: UIButton!
//    @IBOutlet weak var sideMenuMainView: UIView!
//       var btnmenu:UIButton!
//       var delegate:SlideMenuDelegate?
//    var optionArray = [Menuoption]()
//    @IBOutlet weak var username: UILabel!
//    @IBOutlet weak var useremail: UILabel!
//    @IBOutlet weak var userImage: UIImageView!
//    func loadDataofUser() {
//        if let name = OyeBaryaniSessions.shared._UserProfileInfo?.name,let email =  OyeBaryaniSessions.shared._UserProfileInfo?.email,
//           let image = OyeBaryaniSessions.shared._UserProfileInfo?.image {
//            username.text = name
//            useremail.text = email
//            var urlString = "https://oyebiryani.com/images/\(image)"
//            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            if let url = URL(string: urlString )
//            {
//                userImage.layer.cornerRadius = userImage.frame.height/2
//                userImage.clipsToBounds = true
//                userImage.load(url: url)
//            }
//        }}
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        sideMenuMainView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
//        loadDataofUser()
//        if OyeBaryaniSessions.shared._UserProfileInfo?.is_rider ?? "" == "0"{
//            optionArray.append(Menuoption.init(optionname: "My Order", optionImage: #imageLiteral(resourceName: "2")))
//            optionArray.append(Menuoption.init(optionname: "Promotion", optionImage: #imageLiteral(resourceName: "1")))
//            optionArray.append(Menuoption.init(optionname: "My Address", optionImage: #imageLiteral(resourceName: "88c61ffb-e4d2-456a-a6c9-c3a8af3ea240-1")))
//            optionArray.append(Menuoption.init(optionname: "Feedback", optionImage: #imageLiteral(resourceName: "5")))
//            optionArray.append(Menuoption.init(optionname: "Rate us", optionImage: #imageLiteral(resourceName: "6")))
//            optionArray.append(Menuoption.init(optionname: "Share", optionImage: #imageLiteral(resourceName: "7")))
//            optionArray.append(Menuoption.init(optionname: "Logout", optionImage: #imageLiteral(resourceName: "3")))
//        }
//        else{
//            optionArray.append(Menuoption.init(optionname: "Logout", optionImage: #imageLiteral(resourceName: "3")))
//        }
//    }
//
//    @IBAction func crossButton(_ sender: UIButton) {
//        btnmenu.tag = 0
//
//        if (self.delegate != nil) {
//            var index = Int32(sender.tag)
//            if(sender == self.btnCloseMenuOverLay){
//                index = -1
//            }
//            delegate?.slideMenuItemSelectedAtIndex(index)
//        }
//
//        UIView.animate(withDuration: 0.3, animations: { () -> Void in
//            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
//            self.view.layoutIfNeeded()
//            self.view.backgroundColor = UIColor.clear
//        }, completion: { (finished) -> Void in
//            self.view.removeFromSuperview()
//         self.removeFromParentViewController()
//        })
//
//    }
//       @IBAction func goNext(_ sender: UIButton) {
//           delegate?.slideMenuItemSelectedAtIndex(0)
//       }
//       @IBAction func closemenu(_ sender: UIButton) {
//           btnmenu.tag = 0
//
//           if (self.delegate != nil) {
//               var index = Int32(sender.tag)
//               if(sender == self.btnCloseMenuOverLay){
//                   index = -1
//               }
//               delegate?.slideMenuItemSelectedAtIndex(index)
//           }
//
//           UIView.animate(withDuration: 0.3, animations: { () -> Void in
//               self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
//               self.view.layoutIfNeeded()
//               self.view.backgroundColor = UIColor.clear
//           }, completion: { (finished) -> Void in
//               self.view.removeFromSuperview()
//            self.removeFromParentViewController()
//           })
//
//       }
//
//
//}
//extension SideMenuBaseViewController:UITableViewDataSource,UITableViewDelegate
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return optionArray.count
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableTableViewCell", for: indexPath) as! SideMenuTableTableViewCell
//        cell.setData(optionname: optionArray[indexPath.row].optionname, optionImg: optionArray[indexPath.row].optionImage)
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if OyeBaryaniSessions.shared._UserProfileInfo?.is_rider ?? "" == "0"{ delegate?.slideMenuItemSelectedAtIndex(Int32(indexPath.row))
//        }
//        else{
//            delegate?.slideMenuItemSelectedAtIndex(6)
//        }
//    }
//    
//    
//    
//    
//    
//}
