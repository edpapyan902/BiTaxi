

import Foundation
struct PenddingOrder : Codable {
	let current_orders : [Current_Orders]?

	enum CodingKeys: String, CodingKey {

		case current_orders = "current_orders"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		current_orders = try values.decodeIfPresent([Current_Orders].self, forKey: .current_orders)
	}

}

struct Current_Orders : Codable {
    let title : String?
    let id : Int?
    let next_screen : String?
    let text : String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case id = "id"
        case next_screen = "next_screen"
        case text = "text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        next_screen = try values.decodeIfPresent(String.self, forKey: .next_screen)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }
    
}
