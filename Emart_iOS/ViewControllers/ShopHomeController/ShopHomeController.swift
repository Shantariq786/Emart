
import UIKit
import Kingfisher



class ShopHomeController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    var mainCategories:[CategoriesName]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate  = self
        tableview.dataSource  = self
        roundedView.roundCorner([.topRight,.bottomRight], radius: 20)
        searchTextField.delegate = self
        
        fetchMainCategories()
    }

   
   
    @IBAction func searchBtnTapped(_ sender: Any) {
        //move to search screen
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.seachText = searchTextField.text ?? ""
        self.navigationController?.pushViewController(vc , animated: true)
        
    }
    @IBAction func goBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func fetchMainCategories(){
        let param = ["vendor_type":2]
        APIService.sharedInstance.fetchMainCategories(parameters: param){ mainCategory in
            if mainCategory.error == false{
                self.mainCategories = mainCategory.records
                self.tableview.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                
            }
        }failure: { (error) -> (Void) in
            
        }
    }
}



//MARK: -               TABLEVIEW



extension ShopHomeController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell") as! ImagesSliderTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopsCell") as! ShopsTableViewCell
            cell.mainCategories = mainCategories
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.shopsCollectionVIew.reloadData()
            cell.collectionViewHeight.constant = cell.shopsCollectionVIew.contentSize.height
            cell.shopCellProtocol = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        }else{
            return 550
        }
    }
    
    
    
    
}


extension ShopHomeController:ShopCellProtocol{
    func shopCellTapped(indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
        vc.mainCategories = mainCategories
        vc.mainCategoryIndexNumber = indexPath.row
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    
}
