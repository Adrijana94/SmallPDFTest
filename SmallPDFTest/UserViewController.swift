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
		self.view.backgroundColor = .red
		self.navigationItem.setHidesBackButton(false, animated:false)
		addUI()

		email.isUserInteractionEnabled = true
		let tapEmail = UITapGestureRecognizer(target: self, action: #selector(UserViewController.openEmail))
		email.addGestureRecognizer(tapEmail)
		// Do any additional setup after loading the view.
	}


	func addUI ()
	{
		self.view.addSubview(name)
		name.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(110)
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

		self.view.addSubview(userImage)
		userImage.snp.makeConstraints { (make) in
			make.top.equalTo(email.snp.bottom).offset(10)
			make.centerX.equalToSuperview()
			make.height.equalTo(50)
		}
	}


	override func viewWillAppear(_ animated: Bool) {
		self.setData()
	}

	func setData()
	{
		name.text = "\(user.name.first) \(user.name.last)"
		age.text =	"\(user.dob.age)"

//		guard let imageData = self.user.imageData else {
//			print ("No image data for user")
//			return
//		}
//
//		userImage.image = UIImage(data: imageData)
		email.text = "\(user.email)"
		print ("show data")
	}

	@objc func openEmail (sender:UITapGestureRecognizer)
	{
		print ("open email")
			let recipientEmail = "test@gmail.com"
			let subject = "Welcome"
			let body = "This is welcome email :)"

			// Show default mail composer
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
