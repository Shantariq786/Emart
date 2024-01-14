
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import UIKit

//typealias Completion = (DataResponse<Any>) -> Void
typealias Completion = (AFDataResponse<Any>) -> Void
let center = NotificationCenter.default
//var alamoFireManager: Alamofire.SessionManager?
var alamoFireManager: Alamofire.Session?

class NetworkService : NSObject {
    
    static let shared = NetworkService()
    var headers : HTTPHeaders!//= [String: String]()

    private override init()
    {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1000
        configuration.timeoutIntervalForResource = 1000
        
        setAuthorizationToken()
        alamoFireManager = Alamofire.Session(configuration: configuration)
        //alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //MARK: Header Setting
    func setAuthorizationToken() {
        
        headers = [.contentType("application/form-data"),
                   .defaultAcceptEncoding ,
                   .accept("*/*"),
//                   HTTPHeader(name: "consumer-key", value: appSetting?.consumerKey ?? "dadb7a7c1557917902724bbbf5"),
//                   HTTPHeader(name: "consumer-secret", value: appSetting?.consumerSecret ?? "3ba77f821557917902b1d57373"),
//                   HTTPHeader(name: "consumer-ip", value: "192.164.1.1"),
//                   HTTPHeader(name: "consumer-device-id", value: UserStateHolder.deviceToken ?? "456456465"),
//                   HTTPHeader(name: "consumer-nonce", value: "s"),
//                   HTTPHeader(name: "consumer-ip", value: "192.164.1.1")
                   
                   
        ]
        
//        headers = [
//            .authorization("Bearer \(token)"),
//            .contentType("application/json")
//        ]
        
        //headers["Authorization"] = "Bearer ndkjsD13221_W12OI32132131"

//        if UserStateHolder.isUserLoggedIn {
//            
//            if let user = UserStateHolder.loggedInUser
//            {
//                if let token = user.token
//                {
////                    headers["Authorization"] = "Bearer \(token)"
//
//
//                    headers = [
//                        .authorization("Bearer \(token)"),
//                        .contentType("application/json")
//                    ]
//
//                }
//            }
//            
////            if let token = UserStateHolder.token {
////                headers["Authorization"] = "Bearer \(token)"
////            }
//            
//        }
//        headers["Content-type"] = "application/json"
     //   headers["filter_date"] = Date.getActivityLogDate()
    }
    
    func removeAuthorizationToken() {
        
        //headers.removeValue(forKey: "Authorization")
    }
    
    func setDeviceInfo(deviceId: String, deviceToken: String) {
        //print("Device-Id \(deviceId)")
        //print("Device-Token \(deviceToken)")
        headers["Device-Id"] = deviceId
        headers["Device-Token"] = deviceToken
    }
//
//    //MARK: Mappable Webcall
//    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> Void {
    
    
    //MARK: Mappable Webcall
//    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[NSDictionary]?,type:MultipartFormData, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> Void {
//        setAuthorizationToken()
////        alamoFireManager?.request(path, method: method, parameters: params, encoder: type, headers: headers, interceptor: nil).res
//
////        alamoFireManager.
//
//     //   alamoFireManager?.upload(<#T##fileURL: URL##URL#>, with: <#T##URLRequestConvertible#>, interceptor: <#T##RequestInterceptor?#>, fileManager: <#T##FileManager#>)
//
//  //      let multiPartFormData = MultipartFormData(fileManager: <#T##FileManager#>, boundary: <#T##String?#>)
//
////        import Foundation
////        #if canImport(FoundationNetworking)
////        import FoundationNetworking
////        #endif
////
////        var semaphore = DispatchSemaphore (value: 0)
////
////        let parameters = [
////        ] as [[String : Any]]
////
////        let boundary = "Boundary-\(UUID().uuidString)"
////        var body = ""
////        var error: Error? = nil
////        body += "--\(boundary)--\r\n";
////        let postData = body.data(using: .utf8)
////
////        var request = URLRequest(url: URL(string: "https://app.jeetopaisa.com/api/processlogin?email=shkyousaf12@gmail.com&password=123456")!,timeoutInterval: Double.infinity)
////        request.addValue("dadb7a7c1557917902724bbbf5", forHTTPHeaderField: "consumer-key")
////        request.addValue("3ba77f821557917902b1d57373", forHTTPHeaderField: "consumer-secret")
////        request.addValue("192.164.1.1", forHTTPHeaderField: "consumer-ip")
////        request.addValue("456456465", forHTTPHeaderField: "consumer-device-id")
////        request.addValue("s", forHTTPHeaderField: "consumer-nonce")
////        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////
////        request.httpMethod = "POST"
////        request.httpBody = postData
////
////        let task = URLSession.shared.dataTask(with: request) { data, response, error in
////          guard let data = data else {
////            print(String(describing: error))
////            semaphore.signal()
////            return
////          }
////          print(String(data: data, encoding: .utf8)!)
////          semaphore.signal()
////        }
////
////        task.resume()
////        semaphore.wait()
//
//
//        if let paramsss = params{
//
//            for param in paramsss{
//                let paramName = param["key"]!
//                body += "--\(boundary)\r\n"
//                body += "Content-Disposition:form-data; name=\"\(paramName)\""
//                if param["contentType"] != nil {
//                  body += "\r\nContent-Type: \(param["contentType"] as! String)"
//                }
//                let paramType = param["type"] as! String
//                if paramType == "text" {
//                  let paramValue = param["value"] as! String
//                  body += "\r\n\r\n\(paramValue)\r\n"
//                } else {
//                  let paramSrc = param["src"] as! String
//                  let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
//                  let fileContent = String(data: fileData, encoding: .utf8)!
//                  body += "; filename=\"\(paramSrc)\"\r\n"
//                    + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
//                }
//              }
//
//        }
//
//
//
//
//
//
//        alamoFireManager?.upload(multipartFormData: params, to: path).responseObject(completionHandler: { (completionHandler) in
//            completion(completionHandler)
//        })
//
//
//        alamoFireManager?.request(path, method: method, parameters: params, encoding: type as! ParameterEncoding, headers: headers, interceptor: .none).responseObject(completionHandler: { (completionHandler) in
//            completion(completionHandler)
//        })
//    }
    
    
//    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[NSDictionary]?,type:MultipartFormData, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> Void {
//
    func requestMultiPart<T: BaseMappable>(body:[String:Any], url: String, method: HTTPMethod, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> Void{
        let httpHeaders: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
          
        if url.contains("https://api.stripe.com"){
            
            print("Error in stripes")
            
            headers = [
//                    .authorization("Bearer \(stripeKey)")
//
//                //,
                        .contentType("application/form-data"),
                        .defaultAcceptEncoding ,
                        .accept("*/*"),
//                        HTTPHeader(name: "consumer-key", value: "dadb7a7c1557917902724bbbf5"),
//                        HTTPHeader(name: "consumer-secret", value: "3ba77f821557917902b1d57373"),
//                        HTTPHeader(name: "consumer-ip", value: "192.164.1.1"),
//                        HTTPHeader(name: "consumer-device-id", value: "456456465"),
//                        HTTPHeader(name: "consumer-nonce", value: "s"),
//                        HTTPHeader(name: "consumer-ip", value: "192.164.1.1")
            ]
        }
        
        print ("======= network request ======")
      //  os_log("Url:- %{public}@", log:OSLog.default, type: .info, url)
        //os_log("Body:- %{public}@" , log: OSLog.default, type: .info, body)
        
        AF.upload(multipartFormData: { (multiPart) in
            for (key, value) in body{

                //Check for String Data
                if let temp = value as? String {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                //Check for Int Data
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                
                //Check for Boolean Values
                if let temp = value as? Bool{
                    multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                }
                //Check for Arrays
                if let temp = value as? NSArray {
                             temp.forEach({ element in
                                 let keyObj = key + "[]"
                                 if let string = element as? String {
                                     multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                                 } else
                                     if let num = element as? Int {
                                         let value = "\(num)"
                                         multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                                 }
                             })
                         }
                //Check for Images
                if let temp = value as? UIImage{
                    
                    if let jpegImage = temp.jpegData(compressionQuality: 1){
                        multiPart.append(jpegImage, withName: key, fileName: "\(String(Date().timeIntervalSince1970)).jpeg", mimeType: "image/jpeg")
                    }
                    
//                    if let jpegImage = temp.jpegData(compressionQuality: 1){
//                        multiPart.append(jpegImage, withName: key, fileName: "\(String(Date().timeIntervalSince1970)).jpeg", mimeType: "image/jpeg")
//                    }
                }
            }

        }, to: url, method: method, headers: headers).uploadProgress(queue: .main) { (progress) in
            print("Upload Progress \(progress.fractionCompleted)")
        }.responseObject(completionHandler: { (completionHandler) in
                        completion(completionHandler)
                    })
        
//        .responseJSON { (response) in
//            completion(response, nil)
//            
////            switch response.result{
////            case .success(let data):
////                print("SUCCESS")
////                print(data)
////               completion(data,nil)
////            case .failure(let error):
////                print("ERROR")
////                print(error)
////                completion(nil, error.localizedDescription)
////            }
//        }
      
    }
    
    
    
//    //MARK: Mappable Webcall
//    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping (Alamofire.DataResponse<T>) -> Void) -> Void {
//
//
//
//        alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseObject {
//            (completionHandler) in
//                completion(completionHandler)
//        }
//    }
    
    //MARK: Without Mappable Webcall
    func callWebServiceWithoutMapping(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping Completion) -> Void {
        
        alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseJSON {
            (completionHandler) in
            
            completion(completionHandler)
        }
    }
    
    
    
    //MARK: Mappable Webcall
    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:Any]?,type:ParameterEncoding, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> Void {
        setAuthorizationToken()

        
        headers = [.contentType("application/json"),
                   .defaultAcceptEncoding ,
                   .accept("*/*"),
//                   HTTPHeader(name: "consumer-key", value: "dadb7a7c1557917902724bbbf5"),
//                   HTTPHeader(name: "consumer-secret", value: "3ba77f821557917902b1d57373"),
//                   HTTPHeader(name: "consumer-ip", value: "192.164.1.1"),
//                   HTTPHeader(name: "consumer-device-id", value: UserStateHolder.deviceToken ?? "456456465"),
//                   HTTPHeader(name: "consumer-nonce", value: "s"),
//                   HTTPHeader(name: "consumer-ip", value: "192.164.1.1")
        ]

        
        alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers, interceptor: .none).responseObject(completionHandler: { (completionHandler) in
            completion(completionHandler)
        })
    }
    
    //MARK: Mappable with return Request data
    //use this method for if you want to cancel request
    func callWebServiceWithRequestObject<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping (Alamofire.AFDataResponse<T>) -> Void) -> DataRequest {
        
        return (alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseObject {
            (completionHandler) in
            completion(completionHandler)
            })!
    }
    
    func printResponse(data:NSData?) {
        if data != nil {
            //print(String(data: data! as Data, encoding: String.Encoding.utf8))
        }
    }
    
    func cancelAllRequest() {
        alamoFireManager?.session.getTasksWithCompletionHandler{ (dataTasks, uploadTasks, DownloadTasks) in
            dataTasks.forEach{ $0.cancel() }
            uploadTasks.forEach{ $0.cancel() }
            DownloadTasks.forEach{ $0.cancel() }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

