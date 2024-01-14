
import Foundation
import UIKit
import Alamofire

typealias Success = (_ result: AnyObject) -> (Void)
typealias Failure = (_ error: String) -> (Void)

class APIService : NSObject {
    
    //MARK:- SharedInstance
    static let sharedInstance = APIService()
    
    //MARK: Error Code
    var errorCodeList:[Int]?
    
    //MARK:- Init
    private override init() {
        
        super.init()
        errorCodeList = [400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,421,422,423,424,425,426,427,428,429,431,451,-1009]
    }
    
    //MARK:- Error Handling
    func handleError(error:NSError?, failure:Failure, responseCode:Int?) -> Bool{
        if let httpError = error {
            let statusCode = httpError.code
            
            if statusCode == -1009 || statusCode == -1001 {
                showStatusBarAlert(Str: AlertTitle.NETWORK_ERROR, Duration: 2.0)
                failure(AlertTitle.NETWORK_ERROR)
            }
            else if statusCode == -999 {
                // opration cancel by us so no process more
                failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
            }
            else
            {
                failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                showStatusBarAlert(Str: AlertTitle.ALERT_WEBSERVICE_ERROR , Duration: 2.0)
            }
            return true
        }
        else if responseCode != nil && errorCodeList!.contains(responseCode!) {
            
            return true
            //            if (responseCode == 401 || responseCode == 400)
            //            {
            //
            //            }
        }
        return false
    }
    
    
    
//    
//    func registerUser(parameters params: [String:Any], success:@escaping (_ result: UserResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.REGISTER)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.REGISTER, method: .post) { (completion:AFDataResponse<UserResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    func updateUser(parameters params: [String:Any], success:@escaping (_ result: UserResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.UPDATEUSER)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.UPDATEUSER, method: .post) { (completion:AFDataResponse<UserResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func forgotPassword(parameters params: [String:Any], success:@escaping (_ result: BaseModel) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.FORGOTPASSWORD)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.FORGOTPASSWORD, method: .post) { (completion:AFDataResponse<BaseModel>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//
//    func loginUser(parameters params: [String:Any], success:@escaping (_ result: UserResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.LOGIN)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.LOGIN, method: .post) { (completion:AFDataResponse<UserResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//
//    func getAllRequirements(parameters params: [String:Any], url:String, success:@escaping (_ result: RequirementsResult) -> (Void), failure: @escaping Failure) -> (Void){
//        
//       // showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        NetworkService.shared.requestMultiPart(body: params, url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get) { (completion:AFDataResponse<RequirementsResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//              //  hideHud()
//                success(completion.value!)
//            }
//            else{
//              //  hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                //    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//
//    func getAllCountries(parameters params: [String:Any], url:String, success:@escaping (_ result: CountriesResult) -> (Void), failure: @escaping Failure) -> (Void){
////        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        NetworkService.shared.requestMultiPart(body: params, url: url, method: .post) { (completion:AFDataResponse<CountriesResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
////                hideHud()
//                success(completion.value!)
//            }
//            else{
////                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
////                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func backgroundRemovel(parameters params: [String:Any], success:@escaping (_ result: BackgroundRemovel) -> (Void), failure: @escaping Failure) -> (Void){
////        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.BACKGROUNDREMOVEL)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.BACKGROUNDREMOVEL, method: .post) { (completion:AFDataResponse<BackgroundRemovel>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
////                hideHud()
//                success(completion.value!)
//            }
//            else{
////                hideHud()
//                failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
////                hideHud()
////                if let msg = completion.value?.message {
////                    failure(msg)
////                }
////                else{
////
////                }
//            }
//        }
//    }
//    
//    
//    
//    
//    
//    func getCoupon(parameters params: [String:Any], success:@escaping (_ result: CouponsResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.GETCOUPONS)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GETCOUPONS, method: .post) { (completion:AFDataResponse<CouponsResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func getAllProducts(parameters params: [String:Any], success:@escaping (_ result: ProductsResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.GETALLPRODUCTS)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GETALLPRODUCTS, method: .post) { (completion:AFDataResponse<ProductsResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    
//    func getAllSettings(parameters params: [String:Any], url:String, success:@escaping (_ result: SettingsResult) -> (Void), failure: @escaping Failure) -> (Void){
//        
//      //  showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        NetworkService.shared.requestMultiPart(body: params, url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get) { (completion:AFDataResponse<SettingsResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func getStripeResponse(parameters params: [String:Any], url:String, success:@escaping (_ result: StripeResult) -> (Void), failure: @escaping Failure) -> (Void){
//        
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        NetworkService.shared.requestMultiPart(body: params, url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .post) { (completion:AFDataResponse<StripeResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//            }
//        }
//    }
//    
//    
//    
//    func createOrder(parameters params: [String: Any], success:@escaping (_ result: BaseModel) -> (Void), failure: @escaping Failure) -> (Void){
//
//         showHud()
////         print("parameters: \(params)")
//         print("User URL: \(URLPath.CREATEORDER)")
//
//         NetworkService.shared.callWebService(method: .post, path: URLPath.CREATEORDER, params: params, type: JSONEncoding()){
//             (completion:AFDataResponse<BaseModel>) in
//
//
//             if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                 hideHud()
//                 success(completion.value!)
//             }
//             else{
//                 hideHud()
//                 if let msg = completion.value?.message {
//                     failure(msg)
//                 }
//                 else{
//                     hideHud()
//                     failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                 }
//             }
//
//         }
//
//     }
//    
//    
//    
//    func getMyOrders(parameters params: [String:Any], success:@escaping (_ result: OrdersResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.MYORDER)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.MYORDER, method: .post) { (completion:AFDataResponse<OrdersResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func getNews(parameters params: [String:Any], success:@escaping (_ result: NewsResult) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.NEWS)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.NEWS, method: .post) { (completion:AFDataResponse<NewsResult>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
//    
//    
//    
//    func notificationToggle(parameters params: [String:Any], success:@escaping (_ result: BaseModel) -> (Void), failure: @escaping Failure) -> (Void){
//        showHud()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        print("User URL: \(URLPath.NOTIFICATIONTOGGLE)")
//        
//        NetworkService.shared.requestMultiPart(body: params, url: URLPath.NOTIFICATIONTOGGLE, method: .post) { (completion:AFDataResponse<BaseModel>) in
//            
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
//                hideHud()
//                success(completion.value!)
//            }
//            else{
//                hideHud()
//                if let msg = completion.value?.message {
//                    failure(msg)
//                }
//                else{
//                    hideHud()
//                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
//                }
//            }
//        }
//    }
    
    
    
    
    func getCategories(parameters params: [String:Any], success:@escaping (_ result: ResturantFoodCategoryResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetRestaurantCategories, method: .post) { (completion:AFDataResponse<ResturantFoodCategoryResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func getProducts(parameters params: [String:Any], success:@escaping (_ result: RestaurantProductResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetResturantProducts, method: .post) { (completion:AFDataResponse<RestaurantProductResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func getSearchResults(parameters params: [String:Any], success:@escaping (_ result: RestaurantProductResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.SearchProducts, method: .post) { (completion:AFDataResponse<RestaurantProductResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    func showSearchRestaurantsData(url:URL,parameter:Parameters,completion:@escaping ((showRestaurantsAPI?,String)->())) {
      //  let url = "https://emart.pkgadget.com/api/showRestaurants.php"
        AF.request(url, method: .post, parameters: parameter, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showRestaurantsAPI.self, from: json!)
                    print(myData)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    
    func addToCart(parameters params: [String:Any], success:@escaping (_ result: AddToCart) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.AddToCart, method: .post) { (completion:AFDataResponse<AddToCart>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    func updateCart(parameters params: [String:Any], success:@escaping (_ result: UpdateCart) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.UpdateCart, method: .post) { (completion:AFDataResponse<UpdateCart>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func addFavourite(parameters params: [String:Any], success:@escaping (_ result: GenericModel) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.AddFavourite, method: .post) { (completion:AFDataResponse<GenericModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    func getUserOrders(parameters params: [String:Any], success:@escaping (_ result: OrderResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetUserOrders, method: .post) { (completion:AFDataResponse<OrderResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func cancelOrders(parameters params: [String:Any], success:@escaping (_ result: OrderCancel) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.OrderCancle, method: .post) { (completion:AFDataResponse<OrderCancel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func getOrderItems(parameters params: [String:Any], success:@escaping (_ result: OrderItems) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetOrderItems, method: .post) { (completion:AFDataResponse<OrderItems>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }

    func getSpecificOrderDetail(parameters params: [String:Any], success:@escaping (_ result: OrderDetailModel) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.riderDetails, method: .post) { (completion:AFDataResponse<OrderDetailModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                
                if let msg = completion.value?.error_msg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func setFirebaseToken(parameters params: [String:Any], success:@escaping (_ result: FCMTokenModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.tokenDetail, method: .post) { (completion:AFDataResponse<FCMTokenModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
            }
            else{
                if let msg = completion.value?.error_msg {
                    failure(msg)
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    
    
    
    
    func getNotifications(parameters params: [String:Any], success:@escaping (_ result: Notifications) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetNotifications, method: .post) { (completion:AFDataResponse<Notifications>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    print("message \(msg)")
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    
    func registerLoginUser(url:String,parameters params: [String:Any], success:@escaping (_ result: UserResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: url, method: .post) { (completion:AFDataResponse<UserResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func showRestaurantsData(url:URL,parameter:Parameters,completion:@escaping ((showRestaurantsAPI?,String)->())) {
      //  let url = "https://emart.pkgadget.com/api/showRestaurants.php"
        AF.request(url, method: .post, parameters: parameter, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showRestaurantsAPI.self, from: json!)
                    print(myData)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    
    func showUserFavourites(parameter:Parameters,completion:@escaping ((showRestaurantsAPI?,String)->())) {
      //  let url = "https://emart.pkgadget.com/api/showRestaurants.php"
        showHud()
        AF.request(URLPath.ShowFavourite, method: .post, parameters: parameter, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                hideHud()
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showRestaurantsAPI.self, from: json!)
                    print(myData)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                hideHud()
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }

    
    
    
    
    func getUserCart(parameters params: [String:Any], success:@escaping (_ result: RestaurantProductResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.ShowCartProducts, method: .post) { (completion:AFDataResponse<RestaurantProductResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func updateFav(parameters params: [String:Any], success:@escaping (_ result: RestaurantProductResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.AddFavourite, method: .post) { (completion:AFDataResponse<RestaurantProductResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    func updateProfile(parameters params: [String:Any], success:@escaping (_ result: RestaurantProductResult) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.updateProfile, method: .post) { (completion:AFDataResponse<RestaurantProductResult>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    func genericAPIResponse(url: String, parameters params: [String:Any], success:@escaping (_ result: GenericModel) -> (Void), failure: @escaping Failure) -> (Void){
        showHud()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.AddFavourite, method: .post) { (completion:AFDataResponse<GenericModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                hideHud()
                success(completion.value!)
            }
            else{
                hideHud()
                if let msg = completion.value?.errorMsg {
                    failure(msg)
                }
                else{
                    hideHud()
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    
    
    func fetchSliderImages(parameters params: [String:Any], success:@escaping (_ result: SliderModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.GetSliderImages, method: .post) { (completion:AFDataResponse<SliderModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
            }
            else{
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func fetchMainCategories(parameters params: [String:Any], success:@escaping (_ result: MainCategoriesModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.mainCategories, method: .post) { (completion:AFDataResponse<MainCategoriesModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
            }
            else{
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
    }
    
    func fetchSubCategories(parameters params: [String:Any], success:@escaping (_ result: MainCategoriesModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.subCategories, method: .post) { (completion:AFDataResponse<MainCategoriesModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
            }
            else{
                if let msg = completion.value?.message {
                    failure(msg)
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                }
            }
        }
        
    }
    
    func fetchRatings(parameters params: [String:Any], success:@escaping (_ result: RatingModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        showHud()
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.resturantRating, method: .post) { (completion:AFDataResponse<RatingModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
                hideHud()
            }
            else{
                if let msg = completion.value?.message {
                    failure(msg)
                    hideHud()
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                    hideHud()
                }
            }
        }
        
    }
    
    
    func fetchVouchers(parameters params: [String:Any], success:@escaping (_ result: VoucherModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        showHud()
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.userVouchers, method: .post) { (completion:AFDataResponse<VoucherModel>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
                hideHud()
            }
            else{
                if let msg = completion.value?.message {
                    failure(msg)
                    hideHud()
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                    hideHud()
                }
            }
        }
        
    }
    
    func ReadNotification(parameters params: [String:Any], success:@escaping (_ result: NotificationModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.readNotification, method: .post) { (completion:AFDataResponse<NotificationModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
                hideHud()
            }
            else{
                if let msg = completion.value?.error {
                    //failure(msg)
                    hideHud()
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                    hideHud()
                }
            }
        }
        
    }
    
    func ReadAllNotification(parameters params: [String:Any], success:@escaping (_ result: NotificationModel) -> (Void), failure: @escaping Failure) -> (Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkService.shared.requestMultiPart(body: params, url: URLPath.readAllNotifications, method: .post) { (completion:AFDataResponse<NotificationModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.error as NSError?, failure: failure, responseCode: completion.response?.statusCode){
                success(completion.value!)
                hideHud()
            }
            else{
                if let msg = completion.value?.error {
                    //failure(msg)
                    hideHud()
                }
                else{
                    failure(AlertTitle.ALERT_WEBSERVICE_ERROR)
                    hideHud()
                }
            }
        }
        
    }
    
    
    
    
    
    
}
