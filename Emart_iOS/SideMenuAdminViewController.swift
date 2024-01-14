//
//  SideMenuAdminViewController.swift
//  oye baryani
//
//  Created by Apple on 28/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class SideMenuAdminViewController: UIViewController {

   @IBOutlet weak var btnCloseMenuOverLay: UIButton!
     //  var btnmenu:UIButton!
       var delegate:SlideMenuDelegate?
    var optionArray = [Menuoption]()
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
           super.viewDidLoad()
        optionArray.append(Menuoption.init(optionname: "Logout", optionImage: #imageLiteral(resourceName: "2")))

       }
       
       @IBAction func goNext(_ sender: UIButton) {
           
           delegate?.slideMenuItemSelectedAtIndex(0)
       }
       
       @IBAction func closemenu(_ sender: UIButton) {
         //  btnmenu.tag = 0
           
           if (self.delegate != nil) {
               var index = Int32(sender.tag)
               if(sender == self.btnCloseMenuOverLay){
                   index = -1
               }
               delegate?.slideMenuItemSelectedAtIndex(index)
           }
           
           UIView.animate(withDuration: 0.3, animations: { () -> Void in
               self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
               self.view.layoutIfNeeded()
               self.view.backgroundColor = UIColor.clear
           }, completion: { (finished) -> Void in
               self.view.removeFromSuperview()
            self.removeFromParent()
           })
           
       }


}
extension SideMenuAdminViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableTableViewCell", for: indexPath) as! SideMenuTableTableViewCell
        cell.setData(optionname: optionArray[indexPath.row].optionname, optionImg: optionArray[indexPath.row].optionImage)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.slideMenuItemSelectedAtIndex(-1)
    }
    
    
    
    
    
}
