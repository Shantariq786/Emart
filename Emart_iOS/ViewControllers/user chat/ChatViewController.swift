import UIKit
import Firebase
import Alamofire
class ChatViewController: UIViewController {
    var id = "" //"1618306711496"
    var currentUser = "" //"aslam@gmail.com"
    var messagesArray = [MessageModel]()
    var fbRef = FirebaseHelper()
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    private weak var imageView: UIImageView!
        private lazy var imagePicker: ImagePicker = {
            let imagePicker = ImagePicker()
            imagePicker.delegate = self
            return imagePicker
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.register(UINib(nibName: "imageSentTableViewCell", bundle: nil), forCellReuseIdentifier: "imageSentTableViewCell")
        messagesTableView.register(UINib(nibName: "ImageReceiveMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageReceiveMessageTableViewCell")
        messagesTableView.register(UINib(nibName: "textsentMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "textsentMessageTableViewCell")
        messagesTableView.register(UINib(nibName: "textReceriveMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "textReceriveMessageTableViewCell")

        fbRef.firebaseHelperProtocol = self
        fbRef.fetchMessages(orderNumber: id)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        sendBtn.setTitleColor(UIColor.gray, for: .normal)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
 }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            sendBtn.setTitleColor(UIColor.gray, for: .normal)
        }else{
            sendBtn.setTitleColor(UIColor.blue, for: .normal)
        }

    }
    @objc func KeyboardWillShow(sender: NSNotification){

        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }


    }
    @objc func KeyboardWillHide(sender : NSNotification){

        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardSize.height
        }

    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CamerBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "OPTIONS", message: "SELECT IMAGE FROM YOUR CHOICE", preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ [self] (UIAlertAction)in
                imagePicker.photoGalleryAsscessRequest()
            }))
            
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [self] (UIAlertAction)in
                imagePicker.cameraAsscessRequest()
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    @IBAction func sendBtnTapped(_ sender: UIButton) {
        if inputTextField.text == "" {
            return
        }
        fbRef.sendMessage(user:currentUser, text: inputTextField.text!, type: "text", timestamp: getTimeStampMili(), productId: id)
        inputTextField.text = ""
    }
    
    func getTimeStampMili() -> Int{
        let currentTime = NSDate().timeIntervalSince1970 * 1000
        return Int(currentTime)
    }
    
}
//MARK:-                            TABLEVIEW DELEGETE

extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if messagesArray[indexPath.row].user == currentUser {
            //show sender cell
            
            if(messagesArray[indexPath.row].type == "text"){
                //show sender text
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "textsentMessageTableViewCell", for: indexPath) as! textsentMessageTableViewCell
                cell.sentTextLabel.text = messagesArray[indexPath.row].text
                //cell.timeLabel.text = convertMiliToTime(mili: messagesArray[indexPath.row].timestamp)
                return cell
                
            }else{
                
                //show sender image
                let cell = tableView.dequeueReusableCell(withIdentifier: "imageSentTableViewCell", for: indexPath) as! imageSentTableViewCell
                cell.setImage(stringUrl:  messagesArray[indexPath.row].text)
                return cell
            }
            
            
            
        }
        else{
            //show receiver cell
            if(messagesArray[indexPath.row].type == "text"){
                //show receiver text
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "textReceriveMessageTableViewCell", for: indexPath) as! textReceriveMessageTableViewCell
                cell.receiveTextLabel.text = messagesArray[indexPath.row].text
                //cell.timeLabel.text = convertMiliToTime(mili: messagesArray[indexPath.row].timestamp)
                return cell
                
            }else{
                
                //show receiver image
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageReceiveMessageTableViewCell", for: indexPath) as! ImageReceiveMessageTableViewCell
                cell.setImage(stringUrl:  messagesArray[indexPath.row].text)
                return cell
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messagesArray[indexPath.row].type == "text"{
            return UITableView.automaticDimension
        }else{
            return 220
        }
        
    }
    
    func convertMiliToTime(mili:Int)->String{
        let epochTime = TimeInterval(mili) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
       
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let time = formatter.string(from: date)
        return time
    }
    
    
    
}

//MARK:-                                 IMAGE PICKER DELEGETE

extension ChatViewController: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        uploadImage(image: image)
        imagePicker.dismiss()
    }
    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    func uploadImage(image:UIImage){
        let fileName = "img_\(self.getTimeStampMili()).jpeg"
        let httpHeaders: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let body:[String:Any] = ["image":image]
        AF.upload(multipartFormData: { (multiPart) in
          for (key, value) in body{
            
            //Check for Images
            if let temp = value as? UIImage{
                if let jpegImage = temp.jpegData(compressionQuality: 0.8) {
                    multiPart.append(jpegImage, withName: key, fileName: fileName, mimeType: "image/jpeg")
              }
            }
          }
        }, to: "https://emart.pkgadget.com/api/imageupload.php", method: .post, headers: httpHeaders).uploadProgress(queue: .main) { (progress) in
          print("Upload Progress \(progress.fractionCompleted)")
        }.response { [self](response) in
          // response.description
            print("response \(response)")
          if let error = response.error{
            print( "Error \(error.localizedDescription)")
            return
          }else{
            //make document of the image
            print("data uploaded")
            fbRef.sendMessage(user: currentUser, text: fileName, type: "image", timestamp: getTimeStampMili(), productId: id)
            
          }
        }
      }
    
}

//MARK:-                                 FIREBASE HELPER DELEGETE

extension ChatViewController:FirebaseHelperProtocol{
    func FetchMessageFromFirebase(messgae: MessageModel) {
        messagesArray.append(messgae)
        messagesArray.sort { $0.timestamp < $1.timestamp }
        messagesTableView.reloadData()
    }
    
    
    
}


//MARK:-                                    TEXTFIELD DELEGETE

extension ChatViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
