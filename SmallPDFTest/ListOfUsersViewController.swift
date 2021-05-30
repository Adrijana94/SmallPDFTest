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
	let spinner = UIActivityIndicatorView()

	var tableView : UITableView = {
		var table : UITableView = UITableView()
		table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(tableView)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.setViews()
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

	override func viewDidLayoutSubviews() {

		print ("didlayout")
		api.getUsersList(pagination: false) { [weak self] (result) in
			switch result{
			case.success(let users):
				self?.listOfUsers = users.users
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			case .failure(let error):
				print (error.localizedDescription)
				return
			}
		}
	}

	func startSpinner()
	{
		self.spinner.center = self.view.center
		self.spinner.color = .red
		self.view.addSubview(spinner)
		self.spinner.startAnimating()
	}

	func stopSpinner()
	{
		spinner.stopAnimating()
		self.view.willRemoveSubview(self.spinner)
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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let rootVC = UserViewController(user: self.listOfUsers[indexPath.row])
		rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(goBack(sender:)))
		rootVC.navigationItem.title = "\(self.listOfUsers[indexPath.row].name.first)  \(self.listOfUsers[indexPath.row].name.last)"
		let navVC = UINavigationController(rootViewController: rootVC)
		navVC.modalPresentationStyle = .fullScreen
		self.present(navVC, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)

	}

	@objc func goBack(sender: UIBarButtonItem){
		dismiss(animated: true, completion: nil)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		print ("called")
		let position = scrollView.contentOffset.y
		if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height)
		{
			guard !api.isPaginating else
			{
				return
			}

			self.startSpinner()

			api.getUsersList(pagination: true) { [weak self] (result) in
				DispatchQueue.main.async {
					self?.stopSpinner()
				}
				switch result{
				   case.success(let users):
					   self?.listOfUsers.append(contentsOf: users.users)
					   DispatchQueue.main.async {
						   self?.tableView.reloadData()
					   }
				   case .failure(let error):
					   print (error.localizedDescription)
					   return
				}
		   }
	   }

	}
}

