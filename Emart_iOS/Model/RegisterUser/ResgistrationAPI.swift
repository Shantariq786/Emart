

//import Foundation
//struct ResgistrationAPI : Codable {
//	let error : Bool?
//	let user : User?
//
//	enum CodingKeys: String, CodingKey {
//
//		case error = "error"
//		case user = "user"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		error = try values.decodeIfPresent(Bool.self, forKey: .error)
//		user = try values.decodeIfPresent(User.self, forKey: .user)
//	}
//
//}
