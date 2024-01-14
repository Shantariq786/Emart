//
//  UserProfileViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import ObjectMapper
import SVProgressHUD

class UserProfileViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    @IBOutlet weak var userAddressTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var cameraImage: UIButton!
    var showAddressData:ShowAddressAPI?
    
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataofUser()
        cameraImage.setImage(UIImage(named: "photo-camera")?.maskWithColor(color: .white), for: .normal)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        greyView.isUserInteractionEnabled = true
        greyView.addGestureRecognizer(tapGestureRecognizer)
        
        userAddressTextField.isUserInteractionEnabled = false
        
        ShowAddresses()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presentActionSheet()
    }
    
    func loadDataofUser() {
        
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        
        userNameTextField.text = user.name
        userEmailTextField.text = user.email
        userPhoneTextField.text = user.phone
        
        let fullSrtUrl = "\(BASEURL.imageUrl)\(user.image ?? "")"
        print("fullSrtUrl \(fullSrtUrl)")
        let url = URL(string: fullSrtUrl)
        userImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_user"), options: nil, progressBlock: nil, completionHandler: nil)
        
    }
    
    func ShowAddresses(){
        
        guard let user = UserStateHolder.loggedInUser else {
            return
        }
        
        guard let url = URL(string: URLPath.ShowAddresses) else {
            print("URL Error")
            return
        }
       
        let parameter = ["email":user.email ?? ""]
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Loading")
        EMartAPIManager.shared.ShowAddress(url: url, parameter: parameter) {[self] (ShowAddressData, error) in
            SVProgressHUD.dismiss()
            if (error == false){
                let address = ShowAddressData
                showAddressData = address
                showAddressData?.records = address!.records?.sorted(by:{$0.id! > $1.id!})
                userAddressTextField.text = showAddressData?.records![0].address
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Address not Found")
            }
        }
        
        
    }
    
    
    @IBAction func backButtontapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveChangesTapped(_ sender: UIButton) {
        
        updateUserObject(fileName: "thisis")
        
        if userEmailTextField.text == "" || userNameTextField.text == "" || userPhoneTextField.text == ""{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Please fill all inputs")
            return
        }
        
        uploadImage(image: userImageView.image ?? #imageLiteral(resourceName: "user"))
        
    }
    
    
    func getTimeStampMili() -> Int{
        let currentTime = NSDate().timeIntervalSince1970 * 1000
        return Int(currentTime)
    }
    
    func uploadImage(image:UIImage){
        
        
        let fileName = "img_\(self.getTimeStampMili()).jpeg"
        let httpHeaders: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let body:[String:Any] = ["image":image]
        
        //show progress
        showHud()
        
        AF.upload(multipartFormData: { (multiPart) in
            for (key, value) in body{
                
                //Check for Images
                if let temp = value as? UIImage{
                    if let jpegImage = temp.jpegData(compressionQuality: 0.8) {
                        multiPart.append(jpegImage, withName: key, fileName: fileName, mimeType: "image/jpeg")
                    }
                }
            }
        }, to: "\(BASEURL.url)/imageupload.php", method: .post, headers: httpHeaders).uploadProgress(queue: .main) { (progress) in
            print("Upload Progress \(progress.fractionCompleted)")
        }.response { [self](response) in
            // response.description
            print("response \(response)")
            if let error = response.error{
                hideHud()
                print( "Error \(error.localizedDescription)")
                return
            }else{
                
                hideHud()
                //make document of the image
                print("image uploaded")
                
               
                
                let params = ["image":fileName,
                              "name":userNameTextField.text ?? "",
                              "phone":userPhoneTextField.text ?? "",
                              "email":userEmailTextField.text ?? ""]
                
                
                APIService.sharedInstance.updateProfile(parameters: params as [String : Any]) { favouriteRes in
                    if favouriteRes.error == false{
                        
                        updateUserObject(fileName: fileName)
                        UIViewController.showAlertWithoutButton(inViewController: self, message: "Profile Updated")
                        
                        
                    }
                } failure: { (error) -> (Void) in
                    
                }
                
            }
        }
    }
    
    func updateUserObject(fileName:String){
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
       
        let updatedUser = ["active":user.active,
                   "created_at":user.createdAt,
                   "email":userEmailTextField.text ?? "",
                   "encrypted_password":user.encryptedPassword,
                   "facebook_password":user.facebookPassword,
                   "google_password":user.googlePassword,
                   "id":user.id,
                   "image":fileName,
                   "is_rider":user.isRider,
                   "modified":user.modified,
                   "myref":user.myref,
                   "name":userNameTextField.text ?? "",
                   "phone": userPhoneTextField.text ?? "",
                   "ref":user.ref,
                   "salt":user.salt,
                   "salt_facebook":user.saltFacebook,
                   "salt_google":user.saltGoogle,
                   "token":user.token]
        
        UserStateHolder.loggedInUser = User(JSON: updatedUser as [String : Any])
        
        
        
        
        
    }
    
    func presentActionSheet(){
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let addPhotoAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.imagePicker.cameraAsscessRequest()
            
        }
        
        let cameraImage = #imageLiteral(resourceName: "icons8-facebook-old-30")
        addPhotoAction.setValue(cameraImage, forKey: "image")
        addPhotoAction.setValue(UIColor(named: "AppPrimaryPurpleColor"), forKey: "titleTextColor")
        
        
        let addVideoAction = UIAlertAction(title: "Gallery", style: .default) { action -> Void in
            self.imagePicker.photoGalleryAsscessRequest()
        }
        let videImageImage = #imageLiteral(resourceName: "icons8-facebook-old-30")
        addVideoAction.setValue(videImageImage, forKey: "image")
        addVideoAction.setValue(UIColor(named: "AppPrimaryPurpleColor"), forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title:  "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        actionSheetController.addAction(addPhotoAction)
        actionSheetController.addAction(addVideoAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
}


//MARK:-                            IMAGE PICKER


extension UserProfileViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        userImageView.image = image
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

