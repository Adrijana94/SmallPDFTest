//
//  User.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import Foundation

class Users: Decodable {
	let users : [User]

	private enum CodingKeys : String, CodingKey {
		case users = "results"
	}
}

class User: Decodable {
	let gender: String
	let name: Name
	let email: String
	let dob: Dob
	let picture: Picture
	let nat: String
	var imageData: Data?

	enum CodingKeys: String, CodingKey {
			case gender, name, email, dob, picture, nat
		}

	internal required init(from decoder: Decoder, imageData: Data?) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.gender = try container.decode(String.self, forKey: .gender)
		self.name = try container.decode(Name.self, forKey: .name)
		self.email = try container.decode(String.self, forKey: .email)
		self.dob = try container.decode(Dob.self, forKey: .dob)
		self.picture = try container.decode(Picture.self, forKey: .picture)
		self.nat = try container.decode(String.self, forKey: .nat)
		self.imageData = imageData
	}
}

class Name: Decodable {

	let title: String
	let first: String
	let last: String
}


class Dob : Decodable {
	let date: String
	let age: Int
}

class Picture: Decodable {
	let large: String
	let medium: String
	let thumbnail: String
}
