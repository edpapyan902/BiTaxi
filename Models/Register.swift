

import Foundation
struct Register : Codable {
	let status : Int?
	let message : String?
	let key : String?
	let user : ?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case key = "key"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		key = try values.decodeIfPresent(String.self, forKey: .key)
        user = try values.decodeIfPresent(user.self, forKey: .user)
	}

}
