//
//  UserTableViewCell.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import UIKit

class UserTableViewCell: UITableViewCell {

	static let identifier = "userCell"
	var padding = 10
	var height = 20
	

	var name : UILabel = {
		let label = UILabel()
		return label
	}()


	var age : UILabel = {
		let label = UILabel()
		return label
	}()


	var userImage : UIImageView = {
		let image = UIImageView()
		image.sizeToFit()
		return image
	}()


	var nationality : UILabel = {
		let label = UILabel()
		return label
	}()



	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.addSubview(name)
		self.addSubview(age)
		self.addSubview(userImage)
		self.addSubview(nationality)

		addUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func addUI()
	{

		self.userImage.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(padding)
			make.width.equalTo(70)
			make.leading.equalToSuperview().offset(10)
			make.height.equalTo(70)
		}


		self.name.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(5)
			make.leading.equalTo(self.userImage.snp.trailing).offset(20)
			make.trailing.equalToSuperview()
			make.height.equalTo(height)
		}

		self.age.snp.makeConstraints { (make) in
			make.top.equalTo(self.name.snp.bottom).offset(padding)
			make.leading.equalTo(self.userImage.snp.trailing).offset(20)
			make.trailing.equalToSuperview()
			make.height.equalTo(height)
		}



		self.nationality.snp.makeConstraints { (make) in
			make.top.equalTo(self.age.snp.bottom).offset(padding)
			make.leading.equalTo(self.userImage.snp.trailing).offset(20)
			make.trailing.equalToSuperview()
			make.height.equalTo(height)
		}
	}


	func setUserForCell(user: User)
	{
		print (user.name.first)
		self.name.text = "\(user.name.first) \(user.name.last)"
		self.age.text = String (user.dob.age)
		self.nationality.text = user.nat

//		getUserImage(user: user)

	}

//	func getUserImage(user : User)
//	{
//		self.imageView?.loadImage(urlString: user.picture.thumbnail)
//
//	}

}


//extension UIImageView{
//
//	func loadImage(urlString: String)
//	{
//		guard let url = URL(string: urlString) else {
//			print ("No image url")
//			return
//		}
//
//		URLSession.shared.dataTask(with: url) { (data, response, error ) in
//			if error != nil
//			{
//				print ("Error while loading image")
//			}
//
//			guard let data = data else {return}
//
//			DispatchQueue.main.async {
//				self.image = UIImage(data: data)
//			}
//
//		}.resume()
//
//	}
//
//}
