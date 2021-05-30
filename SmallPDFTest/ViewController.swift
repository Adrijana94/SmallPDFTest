//
//  ViewController.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import UIKit

class ViewController: UIViewController {

	var api = APIManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		getUsers(page: "1")
		// Do any additional setup after loading the view.
	}

	func getUsers(page: String)
	{
		api.getUsersList(page: page){ (users) in
			users.users.forEach({print($0.name.first)})
		}
	}


}

