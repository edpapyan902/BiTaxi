

import Foundation
struct Users : Codable {
	let id : Int?
	let full_name : String?
	let email : String?
	let mobile : String?
	let token : String?
	let active : String?
	let nationality_id : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case full_name = "full_name"
		case email = "email"
		case mobile = "mobile"
		case token = "token"
		case active = "active"
		case nationality_id = "nationality_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		active = try values.decodeIfPresent(String.self, forKey: .active)
		nationality_id = try values.decodeIfPresent(Int.self, forKey: .nationality_id)
	}

}
