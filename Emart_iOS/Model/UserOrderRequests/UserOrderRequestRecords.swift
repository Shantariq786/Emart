
import Foundation
struct UserOrderRequestRecords : Codable {
	let id : String?
	let name : String?
	let mobile_number : String?
	let user_email : String?
	let order_number : String?
	let date_time : String?
	let total_price : String?
	let status : String?
	let address : String?
	let gps_address : String?
	let location : String?
	let sec_mobile : String?
	let r_id : String?
	let description : String?
	let accepted_by : String?
	let coupen_off : String?
	let count : String?
	let status_name : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case mobile_number = "mobile_number"
		case user_email = "user_email"
		case order_number = "order_number"
		case date_time = "date_time"
		case total_price = "total_price"
		case status = "status"
		case address = "address"
		case gps_address = "gps_address"
		case location = "location"
		case sec_mobile = "sec_mobile"
		case r_id = "r_id"
		case description = "description"
		case accepted_by = "accepted_by"
		case coupen_off = "coupen_off"
		case count = "count"
		case status_name = "status_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
		user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
		order_number = try values.decodeIfPresent(String.self, forKey: .order_number)
		date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
		total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		gps_address = try values.decodeIfPresent(String.self, forKey: .gps_address)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		sec_mobile = try values.decodeIfPresent(String.self, forKey: .sec_mobile)
		r_id = try values.decodeIfPresent(String.self, forKey: .r_id)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		accepted_by = try values.decodeIfPresent(String.self, forKey: .accepted_by)
		coupen_off = try values.decodeIfPresent(String.self, forKey: .coupen_off)
		count = try values.decodeIfPresent(String.self, forKey: .count)
		status_name = try values.decodeIfPresent(String.self, forKey: .status_name)
	}

}
