
import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD


class ShopDetailsViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView:UICollectionView!
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var mainCategories:[CategoriesName]!
    var subCatgories:[CategoriesName]?
    var resturantProducts : RestaurantProductResult?
    
    var mainCategoryIndexNumber = 0
    var subCatgoryIndexNumber = 0
    let screenSize = UIScreen.main.bounds
    
    var cartSelectedIndex = -1
    var selectedVariationIndex = 0
    
    var selectedIdexpath:IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCollectionView()
        fetchSubCategories()
    }
    
    func initializeCollectionView(){
        self.categoriesCollectionView.register(UINib(nibName: "ShopDetailCollectionviewCell", bundle: nil), forCellWithReuseIdentifier: "ShopDetailCollectionviewCell")
        
        self.subCategoriesCollectionView.register(UINib(nibName: "SubCatColllectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCatColllectionViewCell")
        
        self.productCollectionView.register(UINib(nibName: "ResturntProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResturntProductCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeTheSelectedCellCentered()
    }
    func makeTheSelectedCellCentered(){
        let idxPath = IndexPath(row: mainCategoryIndexNumber, section: 0)
        categoriesCollectionView.scrollToItem(at: idxPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    func fetchSubCategories(){
        resturantProducts = nil
        let param = ["cat_id":mainCategories[mainCategoryIndexNumber].id]
        APIService.sharedInstance.fetchSubCategories(parameters: param as [String : Any]){ subCatgories in
            self.subCatgories?.removeAll()
            if subCatgories.error == false{
                self.subCatgories = subCatgories.records
                self.getProducts(categoryId: self.subCatgories![self.subCatgoryIndexNumber].id ?? "")
            }
            self.productCollectionView.reloadData()
            self.subCategoriesCollectionView.reloadData()
        }failure: { (error) -> (Void) in
            
        }
    }
    func getProducts(categoryId: String){
        resturantProducts = nil
        let email = UserStateHolder.loggedInUser?.email ?? ""
        
        let parameter = ["email": email,
                         "category_id": categoryId] as [String : Any]
        
        APIService.sharedInstance.getProducts(parameters: parameter) { (resturantProducts) -> (Void) in
            self.resturantProducts = resturantProducts
            self.productCollectionView.reloadData()
            
        } failure: { (error) -> (Void) in
            
        }
    }
    @IBAction func goBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK: -           COLLECTIONVIEW PROTOCOL AND DELEGETES

extension ShopDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subCategoriesCollectionView{
            return subCatgories?.count ?? 0
        }else if collectionView == categoriesCollectionView{
            return mainCategories.count
        }else{
            return resturantProducts?.records?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView{
            return setMainCategoriesCollectionViewCell(collectionView, cellForItemAt: indexPath)
        }else if collectionView == subCategoriesCollectionView{
            return setSubCategoriesCollectionViewCell(collectionView, cellForItemAt: indexPath)
        }else{
            return setProductCollectionViewCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func setMainCategoriesCollectionViewCell(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopDetailCollectionviewCell", for: indexPath) as! ShopDetailCollectionviewCell
        
        if indexPath.row == mainCategoryIndexNumber{
            cell.bgView.backgroundColor = UIColor(red: 54/255, green: 36/255, blue: 110/255, alpha: 1)
        }else{
            cell.bgView.backgroundColor = UIColor.clear
        }
        
        cell.setData(title: mainCategories[indexPath.row].name ?? "")
        return cell
    }
    
    func setSubCategoriesCollectionViewCell(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCatColllectionViewCell", for: indexPath) as! SubCatColllectionViewCell
        
        if indexPath.row == subCatgoryIndexNumber{
            cell.roundedView.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            cell.titleLabel.textColor = UIColor.white
        }else{
            cell.roundedView.backgroundColor = UIColor.clear
            cell.titleLabel.textColor = UIColor.darkGray
        }
        
        cell.setData(title: subCatgories![indexPath.row].name ?? "")
        return cell
    }
    func setProductCollectionViewCell(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResturntProductCollectionViewCell", for: indexPath) as! ResturntProductCollectionViewCell
        cell.resturantProductProtocol = self
        
        cell.setData(data: resturantProducts!.records![indexPath.row], indexPath: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoriesCollectionView{
            mainCategoriesTapped(indexPath: indexPath)
        }else if collectionView == subCategoriesCollectionView{
            subCategoriesTapped(indexPath: indexPath)
        }
        
    }
    func mainCategoriesTapped(indexPath: IndexPath){
        if indexPath.row == mainCategoryIndexNumber{
            return
        }
        mainCategoryIndexNumber = indexPath.row
        categoriesCollectionView.reloadData()
        makeTheSelectedCellCentered()
        fetchSubCategories()
    }
    func subCategoriesTapped(indexPath: IndexPath){
        print("tapped at sub Cat")
        subCatgoryIndexNumber = indexPath.row
        subCategoriesCollectionView.reloadData()
        getProducts(categoryId: subCatgories![subCatgoryIndexNumber].id ?? "")
    }
}

extension ShopDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productCollectionView{
            let width = (view.frame.width) / 2.0 - 40
            return CGSize(width: width, height: width + 40)
        }else {
            return CGSize(width: 100, height: 50)
        }
    }

}


// MARK: -                            CUSTOM PROTOCOL
extension ShopDetailsViewController:ResturantProductProtocol{
    func addToCart(indexPath: IndexPath) {
        selectedIdexpath = indexPath
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            loginDoneTapped()
        }
        
    }
    
    func addItemToCart(indexPath: IndexPath) {
        if let quantitynumber = Int(self.resturantProducts?.records?[indexPath.row].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[indexPath.row].quantity = "\(value)"
            self.productCollectionView.reloadItems(at: [indexPath])
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            updateCartItemQuantity(id: (self.resturantProducts?.records?[indexPath.row].id)!, user_email: user.email!, quantity: "\(value)")
        }
    }
    
    func popItemFromCart(indexPath: IndexPath) {
        
        if let quantitynumber = Int(self.resturantProducts?.records?[indexPath.row].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value - 1
            
            self.resturantProducts?.records?[indexPath.row].quantity = "\(value)"
            self.productCollectionView.reloadItems(at: [indexPath])
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            
            if value == 0{
                removetoCart(product_id: (self.resturantProducts?.records?[indexPath.row].id)! , completion: { remove in
                })
              
            }else{
                updateCartItemQuantity(id: (self.resturantProducts?.records?[indexPath.row].id)!, user_email: user.email!, quantity: "\(value)")
            }
            
            
        }
    }
    
    
    
}


//MARK:   -                         CALL APIS TO UPDATED DATA
extension ShopDetailsViewController{
    func addToCart(email: String, product_id: String, variation: String , indexPath:IndexPath){
        let parameter = ["email": email,
                         "product_id": product_id,
                         "variations": variation]
        
        
        APIService.sharedInstance.addToCart(parameters: parameter) { (AddToCart) -> (Void) in
            
            if AddToCart.error == false{
                print(AddToCart.errorMsg)
                if AddToCart.errorMsg == "Added to cart"{
                    self.resturantProducts?.records?[self.cartSelectedIndex].iscart = "1"
                    self.productCollectionView.reloadItems(at: [indexPath])
                }
            }
            
            
        }
        failure: { (error) -> (Void) in
            print(error)
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
            print(AddToCart.errorMsg ?? "")
            
        }
        failure: { (error) -> (Void) in
            print(error)
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
}



//MARK: -               LOGIN PROTOCOL

extension ShopDetailsViewController:LoginProtocol{
    func loginDoneTapped() {
        //update the row
        if let quantitynumber = Int(self.resturantProducts?.records?[selectedIdexpath.row].quantity ?? "0"){
            var value = quantitynumber
            print(value)
            value = value + 1
            
            self.resturantProducts?.records?[selectedIdexpath.row].quantity = "\(value)"
            self.productCollectionView.reloadItems(at: [selectedIdexpath])
        }
        
        //sending data to server
        let index = selectedIdexpath.row
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
            addToCart(email: user.email!, product_id: productId, variation: "0", indexPath: selectedIdexpath)
        }
    }
}
