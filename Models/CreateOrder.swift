import Foundation
struct CreateOrder : Codable {
    let user_id : Int?
    let place_id : Int?
    let place_of_user_lat : String?
    let place_of_user_lng : String?
    let delivery_lat : String?
    let delivery_lng : String?
    let car_type : String?
    let id : Int?
    let images : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case place_id = "place_id"
        case place_of_user_lat = "place_of_user_lat"
        case place_of_user_lng = "place_of_user_lng"
        case delivery_lat = "delivery_lat"
        case delivery_lng = "delivery_lng"
        case car_type = "car_type"
        case id = "id"
        case images = "Images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        place_id = try values.decodeIfPresent(Int.self, forKey: .place_id)
        place_of_user_lat = try values.decodeIfPresent(String.self, forKey: .place_of_user_lat)
        place_of_user_lng = try values.decodeIfPresent(String.self, forKey: .place_of_user_lng)
        delivery_lat = try values.decodeIfPresent(String.self, forKey: .delivery_lat)
        delivery_lng = try values.decodeIfPresent(String.self, forKey: .delivery_lng)
        car_type = try values.decodeIfPresent(String.self, forKey: .car_type)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }
    
}
