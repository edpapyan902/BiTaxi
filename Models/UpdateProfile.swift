/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct UpdateProfile : Codable {
	let status : Int?
	let message : String?
	let key : String?
	let user : Profile?

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
		user = try values.decodeIfPresent(Profile.self, forKey: .user)
	}

}

struct Profile : Codable {
    let id : Int?
    let full_name : String?
    let email : String?
    let mobile : String?
    let token : String?
    let active : String?
    let nationality_id : Int?
    let profile_image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case full_name = "full_name"
        case email = "email"
        case mobile = "mobile"
        case token = "token"
        case active = "active"
        case nationality_id = "nationality_id"
        case profile_image = "profile_image"
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
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }
    
}

