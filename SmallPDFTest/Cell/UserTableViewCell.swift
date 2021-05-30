//
//  UserTableViewCell.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import UIKit

class UserTableViewCell: UITableViewCell {

	var api = APIManager()
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


	var flagImage: UIImageView = {
		let image = UIImageView()
		image.sizeToFit()
		image.contentMode = .scaleAspectFit
		image.isHidden = true
		return image
   }()



	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.addSubview(name)
		self.addSubview(age)
		self.addSubview(userImage)
		self.addSubview(nationality)
		self.addSubview(flagImage)

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


		self.flagImage.snp.makeConstraints { (make) in
			make.top.equalTo(self.age.snp.bottom).offset(padding)
			make.leading.equalTo(self.userImage.snp.trailing).offset(20)
			make.width.equalTo(30)
			make.height.equalTo(30)
		}
	}


	func setUserForCell(user: User, userIndex: Int)
	{
		print (user.name.first)
		self.name.text = "\(user.name.first) \(user.name.last)"
		self.age.text = String (user.dob.age)
		self.nationality.text = user.nat

		guard let flag = UIImage(named: "\(user.nat).png") else
		{
			self.nationality.isHidden = false
			self.flagImage.isHidden = true
			return
		}

		self.nationality.isHidden = true
		self.flagImage.isHidden = false
		self.flagImage.image = flag

		self.getUserImage(user: user, userIndex: userIndex)

	}


	func getUserImage (user: User, userIndex: Int)
	{

		self.api.getUserImage(imageUrl: user.picture.thumbnail) { (data) in
			switch data{
			case .success(let imageData):
				user.imageData = imageData

				guard let imgData = user.imageData else {
					print ("No image for display")
					return
				}
				DispatchQueue.main.async {
					self.userImage.image = UIImage(data: imgData)
				}

				print ("image displayed")
			case .failure(let error):

				print ("No image data")
				return
			}
		}
	}

}

