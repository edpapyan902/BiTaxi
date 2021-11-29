

import Foundation
struct BaseNationalities : Codable {
	let nationalities : [Nationalities]?

	enum CodingKeys: String, CodingKey {

		case nationalities = "nationalities"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		nationalities = try values.decodeIfPresent([Nationalities].self, forKey: .nationalities)
	}

}

import Foundation
struct Nationalities : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
