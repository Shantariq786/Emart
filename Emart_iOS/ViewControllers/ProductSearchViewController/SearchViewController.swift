
import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import Kingfisher

class SearchResturantItemsCell: UITableViewCell{
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var counterView: CardView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
}




class SearchViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var foodBtn:UIButton!
    @IBOutlet weak var resturantBtn:UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentIndex = 0
    var seachText = ""
    
    //MARK:- getProducts
    var resturantProducts : RestaurantProductResult? = nil
    var selectedVariationIndex = 0
    var cartSelectedIndex = -1
    var currentSelected = 0
    
    // resturnat
    var obj_showRestaurants:showRestaurantsAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        productsTableView.register(UINib(nibName: "RestuarantsTableViewCell", bundle: nil), forCellReuseIdentifier: "RestuarantsTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.text = seachText
        currentSelected = 0
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
                         "title": seachText] as [String : Any]
        
        APIService.sharedInstance.getSearchResults(parameters: parameter) { (resturantProducts) -> (Void) in
            self.resturantProducts = resturantProducts
            self.productsTableView.reloadData()
            
        } failure: { (error) -> (Void) in
            
        }

    }
    func fetchResturants(){
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        
        let paramater :[String:Any] = ["email":email,"location":"33.649346,73.079227","title":seachText]
        guard let url = URL(string: "https://edelivero.com/api/searchVendors.php") else {return}
        EMartAPIManager.shared.showRestaurantsData(url: url, parameter: paramater, completion: { data, error in
            if data != nil {
                self.obj_showRestaurants = data
                print("count ",self.obj_showRestaurants?.records?.count as Any)
            } else {
                print("data is empty")
            }
            
            self.productsTableView.reloadData()
        })
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func foodBtnTapped(_ sender:UIButton){
        currentIndex = 0
        setDesign()
        fetchFoodItems()
        
    }
    
    @IBAction func resturantBtnTapped(_ sender:UIButton){
        currentIndex = 1
        setDesign()
        fetchResturants()
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        seachText = searchBar.text ?? ""
        if currentIndex == 0{
            fetchFoodItems()
        }else{
            fetchResturants()
        }
    }
    
}

//MARK: -                       TABLEVIEW PROTOCOLS

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentIndex == 0{
            return resturantProducts?.records?.count ?? 0
        }else{
            return obj_showRestaurants?.records?.count ?? 0
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentIndex == 0{
            return getCellForFood(tableView,indexPath)
        }else{
            return getCellForResutrant(tableView,indexPath)
        }
        
    }
    
    func getCellForFood(_ tableView: UITableView, _ indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResturantItemsCell", for: indexPath) as! SearchResturantItemsCell
        let data = resturantProducts?.records?[indexPath.row]
        cell.itemNameLabel.text = data?.name?.capitalizingFirstLetter()
        cell.itemDescriptionLabel.text = data?.productDescription?.capitalizingFirstLetter()
        cell.itemPriceLabel.text = data?.price
        
        if(data?.variationGroups?.count == 0){
            //show add to cart button
            
            if data?.quantity == "0"{
                cell.addToCartButton.isHidden = false
                cell.counterView.isHidden = true
            }else{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = false
                cell.quantityLabel.text = data?.quantity
            }
            
        }else{
            // do not show cart button
            
            if data?.quantity == "0"{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = true
            }else{
                cell.addToCartButton.isHidden = true
                cell.counterView.isHidden = false
                cell.quantityLabel.text = data?.quantity
            }
        }
        
        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        
        cell.plusButton.tag = indexPath.row
        cell.plusButton.addTarget(self, action: #selector(addItemToCart(sender:)), for: .touchUpInside)
        
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(popItemFromCart(sender:)), for: .touchUpInside)
        
        if let image = data?.images?.first?.image{
            let imageUrl = BASEURL.imageUrl+image
            cell.itemImageView.kf.setImage(with: URL(string: imageUrl))
        }
        
        return cell
    }

    func getCellForResutrant(_ tableView: UITableView, _ indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarantsTableViewCell") as! RestuarantsTableViewCell
        cell.setData(record: obj_showRestaurants?.records?[indexPath.row], indepath: indexPath)
        //cell.allResturantHeatButtonProtocol = self
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentIndex == 0{
            return 140
        }else{
            return 320
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentIndex == 0{
            //        let vc = ProductDetailViewController()
            //        vc.restaurantProduct = resturantProducts?.records?[indexPath.row]
            //        self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let StoryBoard = UIStoryboard(name: "Resturant", bundle: nil)
            let Nextvc = StoryBoard.instantiateViewController(withIdentifier: "ResturantDetailViewController") as! ResturantDetailViewController
            Nextvc.resturantData = self.obj_showRestaurants?.records?[indexPath.row]
            Nextvc.indexPath = indexPath
            Nextvc.resturantDetailProtocol = self
            self.navigationController?.pushViewController(Nextvc,animated: true)
        }

    }
    
}



//MARK: -                           FOOD CART VALUE UPDATE FUNCTIONS

extension SearchViewController{
    @objc func addToCart(sender: UIButton){

        //update the row
        if let quantitynumber = Int(self.resturantProducts?.records?[sender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[sender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: sender.tag)
        }
        
        //sending data to server
        let index = sender.tag
        self.selectedVariationIndex = index
        self.cartSelectedIndex = index
        let data = resturantProducts?.records?[index]
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        if let product = data{
                    guard let productId = product.id else {
                        return
                    }
                    addToCart(email: user.email!, product_id: productId, variation: "0")
        }
    }
    
    
    @objc func addItemToCart(sender: UIButton){
        
        if let quantitynumber = Int(self.resturantProducts?.records?[sender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[sender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: sender.tag)
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            updateCartItemQuantity(id: (self.resturantProducts?.records?[sender.tag].id)!, user_email: user.email!, quantity: "\(value)")
        }
        
        
    }
    
    @objc func popItemFromCart(sender: UIButton){
        if let quantitynumber = Int(self.resturantProducts?.records?[sender.tag].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value - 1
            
            self.resturantProducts?.records?[sender.tag].quantity = "\(value)"
            self.productsTableView.updateRow(row: sender.tag)
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            
            if value == 0{
                removetoCart(product_id: (self.resturantProducts?.records?[sender.tag].id)! , completion: { remove in
                })
              
            }else{
                updateCartItemQuantity(id: (self.resturantProducts?.records?[sender.tag].id)!, user_email: user.email!, quantity: "\(value)")
            }
            
            
        }
        
    }
    func removetoCart(product_id:String,completion:@escaping ((Bool)->Void)) {
        guard let productid = Int(product_id), let user = UserStateHolder.loggedInUser else{
            return
        }
        let parameter:[String:Any] = ["email":user.email ?? "","product_id": productid]
        let urlstring = URLPath.RemovetoCart
        guard let url = URL(string: urlstring) else {
            print("URL Error")
            return
        }
        
        SVProgressHUD.show(withStatus: "Please Wait")
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parameter) { (errorMessage, error) in
            print("done")
            SVProgressHUD.dismiss()
        }
        
        
    }
    

    func updateCartItemQuantity(id: String, user_email: String, quantity: String){
        let parameter = ["id": id,
                         "user_email": user_email,
                         "quantity": quantity]
        
        
        APIService.sharedInstance.updateCart(parameters: parameter) { (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
//                self.navigationController?.popViewController(animated: true)
//                self.getProducts(categoryId: (self.resturantProducts?.records?[self.cartSelectedIndex].id)!)
            }
            print(AddToCart.errorMsg)
            
        }
        failure: { (error) -> (Void) in
            print(error)
        }
    }
    
    
    func addToCart(email: String, product_id: String, variation: String){
        let parameter = ["email": email,
                         "product_id": product_id,
                         "variations": variation]
        
        
        APIService.sharedInstance.addToCart(parameters: parameter) { (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
                
                print(AddToCart.errorMsg)
                if AddToCart.errorMsg == "Added to cart"{
                    self.resturantProducts?.records?[self.cartSelectedIndex].iscart = "1"
                    self.productsTableView.updateRow(row: self.cartSelectedIndex)
                    
//                    self.getProducts(categoryId: (self.resturantData?.id)!)
                }
            }
            
            
        }
        failure: { (error) -> (Void) in
            print(error)
        }
    }
}


//MARK: -                       HEART BTN PROTOCOLS

extension SearchViewController:AllResturantHeatButtonProtocol{
    func allResturantHeartButtonPressed(indepath: IndexPath) {
        
        let currentFavStat = Int((obj_showRestaurants?.records?[indepath.row].is_fav)!)
        if currentFavStat == 0{
            // make it favourite
            obj_showRestaurants?.records?[indepath.row].is_fav = "1"
        }else{
            //remove if from favourite
            obj_showRestaurants?.records?[indepath.row].is_fav = "0"
        }
        
        productsTableView.reloadRows(at: [indepath], with: .none)
        
        
        //update on server
        
        guard let isLike = obj_showRestaurants?.records?[indepath.row].is_fav , let vendor_email = obj_showRestaurants?.records?[indepath.row].email else{return}
        guard let user = UserStateHolder.loggedInUser else{return}

        let parameters =  ["islike" : isLike , "vendor_email":vendor_email , "user_email":user.email]
        print(parameters)
        APIService.sharedInstance.updateFav(parameters: parameters as [String : Any]) { favouriteRes in
            if favouriteRes.error == false{
                print(favouriteRes.error_msg)
            }
        } failure: { (error) -> (Void) in

        }

        
    }
    
}


//MARK: -                       HEART BTN PROTOCOLS

extension SearchViewController:ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath: IndexPath, resturantData: showRestaurantsRecords) {
        print("call from main screen")
        obj_showRestaurants?.records?[indexPath.row] = resturantData
        productsTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
}



//MARK: -                       SEARCH BAR PROTOCOLS

extension SearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
    }
}
