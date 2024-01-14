import Foundation
import ObjectMapper

class SliderModel: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [SliderImages]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}

struct SliderImages: Mappable {
    
    var id: String?
    var image: String?
    var text: String?
    var value: String?
    
    
    init?(map: Map) { }
    init() {
        self.id = ""
        self.image = ""
        self.text = ""
        self.value = ""
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        image <- map["image"]
        text <- map["text"]
        value <- map["value"]
    }
}

