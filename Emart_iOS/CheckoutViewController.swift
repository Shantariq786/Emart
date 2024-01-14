
import UIKit
import SVProgressHUD
import CoreLocation
import RSSelectionMenu
class CheckoutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let blurEffectView = UIView()
    var  AddressesArray = [String]()
    var  emptyarray = [String]()
    var deliveryPriceVari:Int?
    var totalBill:String?
    var orderNumber:String?
    
    var coupenKey:String?
    var SecPhoneNumber:String?
    var promodiscountAmount:Int?
    
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var promocodeView: UIView!
    
    @IBOutlet var SecPhoneNumberView: UIView!
    
    @IBOutlet weak var secondryPhoneNumberTextField: UITextField!
    @IBOutlet weak var discreptionTextField: UITextField!
    @IBOutlet weak var discriptionselectedLabel: UILabel!
    @IBOutlet weak var promoCodeselectedLabel: UILabel!
    @IBOutlet weak var BillLabel: UILabel!
    @IBOutlet weak var deliveryCharges: UILabel!
    @IBOutlet weak var promoAmount: UILabel!
    @IBOutlet weak var totalBillPrice: UILabel!
    
    
    
    var showAddressData:ShowAddressAPI?
    var cartsProducts:CardProductDetail?
    var selectedAddress:String?
    @IBOutlet weak var PromoCodeToken: UITextField!
    @IBOutlet weak var DiscriptionTextField: UITextField!
    
    @IBOutlet weak var cartItemsTableView: UITableView!
    
    var selectedAdress:String = ""
    @IBOutlet weak var selectedAdressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promocodeView.isHidden = true
        self.tableViewHeightConstraint.constant = 0
        self.deliveryPriceVari = 0
        self.promodiscountAmount = 0
        
        CartsProducts()
    }
    
    
    
    @IBAction func SaveSecondryPhoneNumber(_ sender: UIButton){
        
        if secondryPhoneNumberTextField.text == "" {
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Please Enter Phone number")
            
        }else if Int(secondryPhoneNumberTextField.text!) == nil{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Invalid phone number")
        }
        else if secondryPhoneNumberTextField.text!.count < 11 || secondryPhoneNumberTextField.text!.count > 11{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Invalid phone number")
        }else{
            SecPhoneNumber = secondryPhoneNumberTextField.text
            blurEffectView.removeFromSuperview()
            self.ConfirmationAlert(Title: "", message: "Are You Want To Place Order")
        }
    }
    
    @IBAction func CancelSecondryPhoneNumber(_ sender: UIButton){
        blurEffectView.removeFromSuperview()
        
    }
    
    @IBAction func PopNavigationController(_ sender: UIButton){
    self.navigationController?.popViewController(animated: true)
}
    
    @IBAction func applyVoucherTapped(_ sender: Any) {
        let vc = VouchersViewController()
        vc.couponProtocol = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cartsProducts?.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let ShowCartItemCell = tableView.dequeueReusableCell(withIdentifier: "ShowCartItemTableViewCell", for: indexPath) as! ShowCartItemTableViewCell
    ShowCartItemCell.setData(records: (cartsProducts?.records?[indexPath.row])!)
    return ShowCartItemCell
    
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    @IBAction func dismissAction(_ sender: UIButton){
        if sender.tag == 1
        {
            selectedAdressLabel.text = selectedAddress
        }
        else
        {
            selectedAddress = ""
        }
        //   self.BlurViewEffect.isHidden = true
        
        
    }
    
    @IBAction func AddAddress(_ sender: UIButton){
        
        let mainStoryBoard = UIStoryboard(name: "Porfile", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func SelectAddress(_ sender: UIButton){
        
    guard let url = URL(string: URLPath.ShowAddresses)else{
        print("url error")
        return
    }
    guard let user = UserStateHolder.loggedInUser else{
        return
    }
    let parameter = ["email": user.email!]
    EMartAPIManager.shared.ShowAddress(url: url, parameter: parameter) { (ShowAddressData, error) in
        if (error == false)
        {
            self.AddressesArray.removeAll()
            self.showAddressData = ShowAddressData
            for i in (self.showAddressData?.records)!{
                self.AddressesArray.append(i.address ?? "")
                
                
            }
            self.AddressesSelection()
            
        }
        else{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Address not Found")
        }
    }
        
}
    
    @IBAction func CartCheckOut(_ sender: UIButton){
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = UIColor.init(red: 174/255, green: 175/255, blue: 175/255, alpha: 1.0)
        view.addSubview(blurEffectView)
        
        SecPhoneNumberView.frame.size = CGSize(width: blurEffectView.frame.width/1.2,height: blurEffectView.frame.height/3)
        SecPhoneNumberView.center = blurEffectView.center
        blurEffectView.addSubview(SecPhoneNumberView)
    }
    
}


extension CheckoutViewController{
    
    func CartsProducts(){
        
        guard let url = URL(string: URLPath.ShowCartProducts) else {
            print("url error")
            return
        }
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        let parameters =  ["email" : user.email!]
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Loading")
        EMartAPIManager.shared.getCartsProduct(url: url, parameter: parameters) { (cartsproduct, error) in
            SVProgressHUD.dismiss()
            if error == false{
                self.cartsProducts = cartsproduct
                self.carttableReload { (bool) in
                    //  self.viewWillLayoutSubviews()
                    
                }
                //   self.reloadTableView()
            }
        }
        
        
        
        
    }
    
    func carttableReload(compeletion: (Bool?) -> Void){
        self.cartItemsTableView.reloadData()
        self.cartItemsTableView.layoutIfNeeded()
        self.tableViewHeightConstraint.constant = self.cartItemsTableView.contentSize.height + 10
        self.cartItemsTableView.layoutIfNeeded(); self.cartItemsTableView.performBatchUpdates({
            //           self.viewWillLayoutSubviews()
            //          //  self.updateViewConstraints()
            
            self.BillLabel.text = "RS \(Billprice())"
            self.deliveryCharges.text = "RS \(self.deliveryPriceVari ?? 0)"
            
            self.totalBillPrice.text = "RS \(Billprice() + (self.deliveryPriceVari ?? 0))"
            self.totalBill = "RS \(Billprice() + (self.deliveryPriceVari ?? 0))"
        }, completion: nil)
        compeletion(true)
        
        
    }
    
    func checkCopen(copennumber:String){
        guard let url = URL(string: URLPath.AddCoupon) else {
            print("url error")
            return
        }
        let price = CalculateSizeOrderZeroPrice()
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        let parameters:[String:Any] =  ["coupon_key":copennumber,"user_email" : user.email! ,"price":price]
        EMartAPIManager.shared.CheckCopen(url: url , parameter: parameters) { (errormessage,price,error) in
            if error == false
            {
                self.promocodeView.isHidden = false
                self.coupenKey = copennumber
                if let copenPrice = price
                {
                    self.promodiscountAmount = Int(copenPrice)
                    self.calculateTotalBill()
                    
                }
                
            }
            else if error == true{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Promo Code Not Found")
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: errormessage!)
            }
        }
        
        
    }
    
    func calculateTotalBill(){
        
        if let promo = promodiscountAmount ,let deliverycharges = deliveryPriceVari{
            self.promoAmount.text = "RS -\(promo)"
            self.totalBillPrice.text = "RS \(( Billprice() + deliverycharges) - promo)"
            self.totalBill = "\(( Billprice() + (deliverycharges)) - promo)"
        }
        
    }
    
}

extension CheckoutViewController{
    
    func CheckOrder(parametar:[String:Any]){
        print("check order call")
        
        guard let url = URL(string:URLPath.AddOrder)else{
            print("url error")
            return
        }
        
        
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: parametar) { (errormessage, error) in
            print("error come ",error)
            if (error == false){
                self.openSucessScreen()
                
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Address not Found")
            }
        }
        
        
        
        
    }
    func openSucessScreen(){
        let vc = OrderPlacedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func Billprice()->Int{
        
        var totalbill:Int = 0
        if let records = self.cartsProducts?.records{
            for item in records {
                
                if let counter = Int(item.quantity!), let price = Int(item.price!){
                    let priceperitem = counter * price
                    totalbill = totalbill + priceperitem
                }
                
            }
            
            
        }
        return totalbill
    }
    
    
    
    func CalculateSizeOrderZeroPrice() -> Int{
        var amount:Int = 0
        let typeoneProducts = self.cartsProducts?.records?.filter { ($0.side_order?.contains("0"))! }
        if let records = typeoneProducts{
            for item in records {
                
                if let counter = Int(item.quantity!), let price = Int(item.price!){
                    let priceperitem = counter * price
                    amount = amount + priceperitem
                }
                
            }
            
            
        }
        return amount
    }
    
    
    func AddressesSelection(){
        
        
        let selectionMenu = RSSelectionMenu(dataSource: AddressesArray) { (cell, item, indexPath) in
            
            cell.textLabel?.text = item
        }
        
        selectionMenu.setSelectedItems(items: emptyarray) { [weak self] (item, index, isSelected, selectedItems) in
            
            self?.selectedAdressLabel.text = self?.AddressesArray[index]
            self?.selectedAdress = self?.showAddressData?.records?[index].id ??
                ""
            self?.deliveryPriceVari =      self?.calculateCharges(location: self?.showAddressData?.records?[index].location ??
                                                                    "" )
            self?.deliveryCharges.text = "RS \(self?.deliveryPriceVari ?? 0)"
            //                    self?.totalBillPrice.text = "\((self?.Billprice() ?? 0) + (self?.deliveryPriceVari ?? 0))"
            self?.calculateTotalBill()
        }
        
        // selectionMenu.show(style: .present, from: self)
        selectionMenu.cellSelectionStyle = .checkbox
        
        selectionMenu.show(style: .alert(title: "Select Addresses", action: "OK", height: nil), from: self)
        
        
    }
    
    func ConfirmationAlert(Title:String,message:String){
        let Alert = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        Alert.addAction( UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.ConfirmOrder()
        })
        
        Alert.addAction( UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(Alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
}

extension CheckoutViewController{
    
    func ConfirmOrder(){
        
        if Connectivity.isConnectedToInternet(){
            guard let user = UserStateHolder.loggedInUser else{
                return
            }
            
            
            if let name = user.name , let mobilenumber = user.phone , let email = user.email{
                let order_number = arc4random()
                if selectedAdress == nil{
                    UIViewController.showAlertWithoutButton(inViewController: self, message: "Please select Address")
                    return
                }
                
                print("selected_address ",selectedAdress)
               
                let priceString = totalBill!.dropFirst(3)
                print("priceString ",priceString)
                let totalprice = Double(priceString ?? "0")
                let parameter:[String:Any] = ["name":name,
                                              "mobile_number":mobilenumber,
                                              "user_email":email,
                                              "order_number":order_number,
                                              "total_price":totalprice,
                                              "selected_address":selectedAdress ,
                                              "description":DiscriptionTextField.text ?? "" ,
                                              "sec_mobile":SecPhoneNumber ?? "",
                                              "coupen_key":coupenKey ?? ""]
                
                print("parameter ",parameter)
                
                
                self.CheckOrder(parametar: parameter)
            }
        }
        else
        {
            UIViewController.showAlertWithoutButton(inViewController: self, message: "No Internet Connection")
            
        }
        
    }
    
    func  calculateCharges(location:String)->Int
    {
        let fare = UserDefaults.standard.value(forKey: "delivery_charges") as? String
        if let charges = Int(fare ?? "00")
        {
            let userlocation = location.split(separator: ",")
            if let userlat = Double(userlocation[0]),let userlong = Double(userlocation[1])
            {
                let distance = Int(self.distance(lat1:31.452363 , lon1:74.293262, lat2:userlat, lon2:userlong, unit:"K"))
                if distance <= 6
                {
                    return 45
                    
                }
                else
                {
                    return  (distance * charges) - 11
                }
                
                
                
                
            }
            
        }
        return 0
    }
}

extension CheckoutViewController{
    func deg2rad(deg:Double) -> Double {
        return deg * Double.pi / 180
    }
    
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / Double.pi
    }
    
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        //        let theta = lon1 - lon2
        //        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        //        dist = acos(dist)
        //        dist = rad2deg(rad: dist)
        //        dist = dist * 60 * 1.1515
        //        if (unit == "K") {
        //            dist = dist * 1.609344
        //        }
        //        else if (unit == "N") {
        //            dist = dist * 0.8684
        //        }
        
        
        //My location
        let myLocation = CLLocation(latitude: lat1, longitude: lon1)
        
        //My buddy's location
        let baryani = CLLocation(latitude: lat2, longitude: lon2)
        
        //Measuring my distance to my buddy's (in km)
        let distance = myLocation.distance(from: baryani) / 1000
        
        //Display the result in km
        print(String(format: "The distance to my buddy is %.01fkm", distance))
        return distance+1
    }
}

extension CheckoutViewController:CouponProtocol{
    func couponSelected(value: String) {
        print("come")
        checkCopen(copennumber: value)
    }
    
    
}
