

import Foundation
struct TermOfUse : Codable {
	let terms_of_use : String?

	enum CodingKeys: String, CodingKey {

		case terms_of_use = "terms_of_use"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		terms_of_use = try values.decodeIfPresent(String.self, forKey: .terms_of_use)
	}

}
