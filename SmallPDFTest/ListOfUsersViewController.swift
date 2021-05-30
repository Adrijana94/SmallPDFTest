//
//  ViewController.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import UIKit
import SnapKit

class ListOfUsersViewController: UIViewController {

	var api = APIManager()
	var listOfUsers = [User]()

	var tableView : UITableView = {
		var table : UITableView = UITableView()
		table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(tableView)
		self.setViews()
		self.getUsers(page: "1")
		print ("viewDidLoad")
	}


	func setViews() {
		tableView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
		}
	}

	func getUsers(page: String)
	{
		api.getUsersList(page: page){ (users) in
			print (users.users)
			self.listOfUsers = users.users
			print (self.listOfUsers.count)
			self.tableView.delegate = self
			self.tableView.dataSource = self
			self.tableView.reloadData()
		}
	}
}


extension ListOfUsersViewController : UITableViewDataSource, UITableViewDelegate
{

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if self.listOfUsers.count > 0
		{
			return self.listOfUsers.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
		cell.setUserForCell(user: self.listOfUsers[indexPath.row])
		return cell
	}


	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

}

