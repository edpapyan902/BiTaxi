/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Results : Codable {
	let address_components : [Address_components]?
	let formatted_address : String?
	let geometry : Geometry?
	let place_id : String?
	let plus_code : Plus_code?
	let types : [String]?

	enum CodingKeys: String, CodingKey {

		case address_components = "address_components"
		case formatted_address = "formatted_address"
		case geometry = "geometry"
		case place_id = "place_id"
		case plus_code = "plus_code"
		case types = "types"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address_components = try values.decodeIfPresent([Address_components].self, forKey: .address_components)
		formatted_address = try values.decodeIfPresent(String.self, forKey: .formatted_address)
		geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
		place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
		plus_code = try values.decodeIfPresent(Plus_code.self, forKey: .plus_code)
		types = try values.decodeIfPresent([String].self, forKey: .types)
	}

}