

import Foundation
import Firebase
struct MessageModel {
    var text:String
    var timestamp:Int
    var user:String
    var type:String
    
    init(text:String ,timestamp:Int,user:String,type:String ){
        self.text = text
        self.timestamp = timestamp
        self.user = user
        self.type = type
    }
}
