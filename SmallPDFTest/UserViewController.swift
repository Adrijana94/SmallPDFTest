//
//  UserViewController.swift
//  SmallPDFTest
//
//  Created by Adrijana Avalic on 30.5.21..
//

import UIKit
import MessageUI

class UserViewController: UIViewController, MFMailComposeViewControllerDelegate {

	var user : User
	internal required init(user: User) {
		   self.user = user
		   super.init(nibName: nil, bundle: nil)
	   }

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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


	var email : UILabel = {
		let label = UILabel()
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .yellow
		self.navigationItem.setHidesBackButton(false, animated:false)
		addUI()

		email.isUserInteractionEnabled = true
		let tapEmail = UITapGestureRecognizer(target: self, action: #selector(UserViewController.openEmail))
		email.addGestureRecognizer(tapEmail)
	}


	func addUI ()
	{

		self.view.addSubview(userImage)
		userImage.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(150)
			make.centerX.equalToSuperview()
			make.height.equalTo(100)
			make.width.equalTo(100)
		}

		self.view.addSubview(name)
		name.snp.makeConstraints { (make) in
			make.top.equalTo(userImage.snp.bottom).offset(10)
			make.trailing.equalToSuperview()
			make.leading.equalToSuperview()
			make.height.equalTo(30)
		}

		self.view.addSubview(age)
		age.snp.makeConstraints { (make) in
			make.top.equalTo(name.snp.bottom).offset(10)
			make.trailing.equalToSuperview()
			make.leading.equalToSuperview()
			make.height.equalTo(30)
		}

		self.view.addSubview(email)
		email.snp.makeConstraints { (make) in
			make.top.equalTo(age.snp.bottom).offset(10)
			make.trailing.equalToSuperview()
			make.leading.equalToSuperview()
			make.height.equalTo(30)
		}
	}


	override func viewWillAppear(_ animated: Bool) {
		self.setData()
	}

	func setData()
	{
		name.text = "\(user.name.first) \(user.name.last)"
		age.text =	"\(user.dob.age)"
		email.text = "\(user.email)"
		print ("show data")

		guard let imageData = self.user.imageData else {
			print ("No image data for user")
			return
		}

		userImage.image = UIImage(data: imageData)
	}

	@objc func openEmail (sender:UITapGestureRecognizer)
	{
		print ("open email")
			let recipientEmail = "test@gmail.com"
			let subject = "Welcome"
			let body = "This is welcome email :)"

			if MFMailComposeViewController.canSendMail() {
				let mail = MFMailComposeViewController()
				mail.mailComposeDelegate = self
				mail.setToRecipients([recipientEmail])
				mail.setSubject(subject)
				mail.setMessageBody(body, isHTML: false)

				present(mail, animated: true)
			}
	}

	internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		 switch result {
		 case .cancelled:
			 print("Mail cancelled")
		 case .saved:
			 print("Mail saved")
		 case .sent:
			 print("Mail sent")
		 case .failed:
			 print("Mail sent failure")
		 default:
			 break
		 }
		 self.dismiss(animated: true, completion: nil)

	}
}
