//
//  APIManager.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import Foundation


class APIManager
{
	var url = "https://randomuser.me/api?page=1&results=20"

	func getUsersList (page: String, completion : @escaping (Users) -> ())
	{

		let endpoint = "https://randomuser.me/api?page=\(page)&results=20"
		guard let url = URL(string: endpoint) else {
			print ("Invalid URL")
			return
		}

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			print ("datatask")
			guard let data = data else
			{
				print ("No data")
				return
			}

			do{
				let jsonData = try JSONDecoder().decode(Users.self, from: data)

				DispatchQueue.main.async {
					print (jsonData)
					completion(jsonData)
				}

			}
			catch let jsonError {
				print ("Decoding failed: \(jsonError)")
			}
		}.resume()
	}

}
