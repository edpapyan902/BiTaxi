
import Foundation
struct user : Codable {
	let id : Int?
	let full_name : String?
	let email : String?
	let mobile : String?
	let active : String?
	let verfication_code : String?
	let nationality_id : String?
	let profile_image : String?
	let token : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case full_name = "full_name"
		case email = "email"
		case mobile = "mobile"
		case active = "active"
		case verfication_code = "verfication_code"
		case nationality_id = "nationality_id"
		case profile_image = "profile_image"
		case token = "token"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		active = try values.decodeIfPresent(String.self, forKey: .active)
		verfication_code = try values.decodeIfPresent(String.self, forKey: .verfication_code)
		nationality_id = try values.decodeIfPresent(String.self, forKey: .nationality_id)
		profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
		token = try values.decodeIfPresent(String.self, forKey: .token)
	}

}
