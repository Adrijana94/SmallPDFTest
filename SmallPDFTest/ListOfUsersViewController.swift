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
		self.setViews()
		self.tableView.delegate = self
		self.tableView.dataSource = self
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

		self.getUsers(pagination: false)
	}

	func getUsers (pagination: Bool)
	{
		self.startSpinner()
		api.getUsersList(pagination: pagination) { [weak self] (result) in
			switch result{
			case.success(let response):
				self?.listOfUsers.append(contentsOf: response.users)
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
				self?.stopSpinner()
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
		let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
		cell.api = self.api

		//needed for cell image reloading
		cell.indexPath = indexPath
		cell.tableView = tableView

		cell.setUserForCell(user: self.listOfUsers[indexPath.row])
		return cell
	}


	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
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
			self.getUsers(pagination: true)
		}

	}
}

