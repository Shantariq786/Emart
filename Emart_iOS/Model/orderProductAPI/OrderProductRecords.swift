
import Foundation
struct orderProductRecords : Codable {
	let id : String?
	let image : String?
	let name : String?
	let flavour : String?
	let price : String?
	let cat_id : String?
	let product_description : String?
	let image_1 : String?
	let image_2 : String?
	let image_3 : String?
	let size : String?
	let side_order : String?
	let quantity : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case image = "image"
		case name = "name"
		case flavour = "flavour"
		case price = "price"
		case cat_id = "cat_id"
		case product_description = "product_description"
		case image_1 = "image_1"
		case image_2 = "image_2"
		case image_3 = "image_3"
		case size = "size"
		case side_order = "side_order"
		case quantity = "quantity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		flavour = try values.decodeIfPresent(String.self, forKey: .flavour)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
		product_description = try values.decodeIfPresent(String.self, forKey: .product_description)
		image_1 = try values.decodeIfPresent(String.self, forKey: .image_1)
		image_2 = try values.decodeIfPresent(String.self, forKey: .image_2)
		image_3 = try values.decodeIfPresent(String.self, forKey: .image_3)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		side_order = try values.decodeIfPresent(String.self, forKey: .side_order)
		quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
	}

}
