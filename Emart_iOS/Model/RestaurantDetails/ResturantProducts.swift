
import Foundation
import ObjectMapper



class RestaurantProductResult: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [RestaurantProduct]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}





struct RestaurantProduct: Mappable {
    
    var discountPrice: String?
    var id: String?
    var images: [Images]?
    var iscart: String?
    var name: String?
    var price: String?
    var productDescription: String?
    var quantity: String?
    var restaurantEmail: String?
    var sideOrder: String?
    var size: String?
    var status: String?
    var subCategoriesId: String?
    var variationGroups: [VariationGroups]?
    var variations: AnyObject?
    var vendor: Vendor?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        discountPrice <- map["discount_price"]
        id <- map["id"]
        images <- map["images"]
        iscart <- map["iscart"]
        name <- map["name"]
        price <- map["price"]
        productDescription <- map["product_description"]
        quantity <- map["quantity"]
        restaurantEmail <- map["restaurant_email"]
        sideOrder <- map["side_order"]
        size <- map["size"]
        status <- map["status"]
        subCategoriesId <- map["sub_categories_id"]
        variationGroups <- map["variation_groups"]
        variations <- map["variations"]
        vendor <- map["vendor"]
    }
}




struct Images: Mappable {
    
    var id: String?
    var image: String?
    var productId: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    id <- map["id"]
    image <- map["image"]
    productId <- map["product_id"]
    }
    
}



struct Variations: Mappable {
    
    var createdAt: String?
    var id: String?
    var isChecked: Bool?
    var name: String?
    var price: String?
    var productVariationId: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    createdAt <- map["created_at"]
    id <- map["id"]
    isChecked <- map["isChecked"]
    name <- map["name"]
    price <- map["price"]
    productVariationId <- map["product_variation_id"]
    }
    
}




struct Vendor: Mappable {
    
    var address: String?
    var descriptionField: String?
    var email: String?
    var endTime: String?
    var header: String?
    var id: String?
    var location: String?
    var name: String?
    var password: String?
    var phone: String?
    var radius: String?
    var role: String?
    var secId: String?
    var startTime: String?
    var status: String?
    var thumb: String?
    var timings: String?
    var typeId: String?
    var vendorEmail: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        address <- map["address"]
        descriptionField <- map["description"]
        email <- map["email"]
        endTime <- map["end_time"]
        header <- map["header"]
        id <- map["id"]
        location <- map["location"]
        name <- map["name"]
        password <- map["password"]
        phone <- map["phone"]
        radius <- map["radius"]
        role <- map["role"]
        secId <- map["sec_id"]
        startTime <- map["start_time"]
        status <- map["status"]
        thumb <- map["thumb"]
        timings <- map["timings"]
        typeId <- map["type_id"]
        vendorEmail <- map["vendor_email"]
    }
}


struct VariationGroups: Mappable {
    
    var id: String?
    var productId: String?
    var required: String?
    var selection: String?
    var title: String?
    var variations: [Variations]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    id <- map["id"]
    productId <- map["product_id"]
    required <- map["required"]
    selection <- map["selection"]
    title <- map["title"]
    variations <- map["variations"]
    }
    
}


