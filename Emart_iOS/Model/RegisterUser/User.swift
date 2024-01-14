
import Foundation
import ObjectMapper


class UserResult: BaseModel {
    var error : Bool?
    var user : User?
    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        user <- map["user"]
    }
}

class User: BaseModel {
    
    var active: String?
    var createdAt: String?
    var email: String?
    var encryptedPassword: String?
    var facebookPassword: String?
    var googlePassword: String?
    var id: String?
    var image: String?
    var isRider: String?
    var modified: String?
    var myref: String?
    var name: String?
    var phone: String?
    var ref: String?
    var salt: String?
    var saltFacebook: String?
    var saltGoogle: String?
    var token: String?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        active <- map["active"]
        createdAt <- map["created_at"]
        email <- map["email"]
        encryptedPassword <- map["encrypted_password"]
        facebookPassword <- map["facebook_password"]
        googlePassword <- map["google_password"]
        id <- map["id"]
        image <- map["image"]
        isRider <- map["is_rider"]
        modified <- map["modified"]
        myref <- map["myref"]
        name <- map["name"]
        phone <- map["phone"]
        ref <- map["ref"]
        salt <- map["salt"]
        saltFacebook <- map["salt_facebook"]
        saltGoogle <- map["salt_google"]
        token <- map["token"]
    }
    
    
    
    required init?(map: Map) {
        
        super.init(map: map)
    }
    
    required init(coder aDecoder: NSCoder) {
        active = aDecoder.decodeObject(forKey: "active") as? String
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        encryptedPassword = aDecoder.decodeObject(forKey: "encrypted_password") as? String
        facebookPassword = aDecoder.decodeObject(forKey: "facebook_password") as? String
        googlePassword = aDecoder.decodeObject(forKey: "google_password") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        isRider = aDecoder.decodeObject(forKey: "is_rider") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        myref = aDecoder.decodeObject(forKey: "myref") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        ref = aDecoder.decodeObject(forKey: "ref") as? String
        salt = aDecoder.decodeObject(forKey: "salt") as? String
        saltFacebook = aDecoder.decodeObject(forKey: "salt_facebook") as? String
        saltGoogle = aDecoder.decodeObject(forKey: "salt_google") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        super.init(coder: aDecoder)
    }
    
    
    public override func encode(with aCoder: NSCoder) {
          if active != nil{
              aCoder.encode(active, forKey: "active")
          }
          if createdAt != nil{
              aCoder.encode(createdAt, forKey: "created_at")
          }
          if email != nil{
              aCoder.encode(email, forKey: "email")
          }
          if encryptedPassword != nil{
              aCoder.encode(encryptedPassword, forKey: "encrypted_password")
          }
          if facebookPassword != nil{
              aCoder.encode(facebookPassword, forKey: "facebook_password")
          }
          if googlePassword != nil{
              aCoder.encode(googlePassword, forKey: "google_password")
          }
          if id != nil{
              aCoder.encode(id, forKey: "id")
          }
          if image != nil{
              aCoder.encode(image, forKey: "image")
          }
          if isRider != nil{
              aCoder.encode(isRider, forKey: "is_rider")
          }
          if modified != nil{
              aCoder.encode(modified, forKey: "modified")
          }
          if myref != nil{
              aCoder.encode(myref, forKey: "myref")
          }
          if name != nil{
              aCoder.encode(name, forKey: "name")
          }
          if phone != nil{
              aCoder.encode(phone, forKey: "phone")
          }
          if ref != nil{
              aCoder.encode(ref, forKey: "ref")
          }
          if salt != nil{
              aCoder.encode(salt, forKey: "salt")
          }
          if saltFacebook != nil{
              aCoder.encode(saltFacebook, forKey: "salt_facebook")
          }
          if saltGoogle != nil{
              aCoder.encode(saltGoogle, forKey: "salt_google")
          }
          if token != nil{
              aCoder.encode(token, forKey: "token")
          }
        super.encode(with: aCoder)
      }
    
    
}





