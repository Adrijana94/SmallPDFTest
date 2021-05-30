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
	var page = 1
	var isPaginating : Bool = false

	func getUsersList (pagination: Bool, completion : @escaping (Result<Users, Error>) -> ())
	{
		if pagination
		{
			self.page += 1
			isPaginating = true
		}
		let endpoint = "https://randomuser.me/api?page=\(self.page)&results=20"
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

				DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 1), execute:  {
					print (jsonData)
					completion(.success(jsonData))

					if self.isPaginating{
						self.isPaginating = false
					}
				})

			} catch let jsonError {
				print ("Decoding failed: \(jsonError)")
			}
		}.resume()
	}

}
