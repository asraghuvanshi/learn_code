//
//  RegisterViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 03/12/2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController : UIViewController {
    //  MARK:  UIView IBOutlet Connections
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var bttnMale: UIButton!
    @IBOutlet weak var bttnFemale: UIButton!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var bttnSignup: UIButton!
    
    
    //  MARK:  Variable Declarations
    private var isGenderSelected:Bool = false
    
    
    //  MARK:  UIView IBOutlet Connection
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIView()
    }
    
    
    //  MARK:  OnClick Signup Button Action
    @IBAction func onClickSignupAction(_ sender: Any) {
        guard let userName = nameTextField.text ,let email = emailTextField.text , let password =  passwordTextField.text, let mobile = phoneTextField.text else { return }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authUser, error  in
            guard let error = error else { return }
            
            let user = ChatUser(name: userName, email: email, phone: mobile)
            DatabaseManager.databaseManager.addUser(with: user, completion: { success in
                if success {
                    guard let image = UIImage(named: "image1"), let data = image.pngData()
                    else { return }
                    
                    let filename = user.profileUrl
                    StorageManger.shared.uploadProfile(with: data, filename: filename, completion: { result in
                        print(result)
                    })
                }
            })
            
        })
    }
    
    //  MARK:  OnClick Gender Clicked Action
    @IBAction func onClickGenderAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            self.bttnMale.configureButton(title: UIButtonTitle.genderMale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioFill)
            self.bttnFemale.configureButton(title: UIButtonTitle.genderFemale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioUnfill)
            
        } else {
            self.bttnMale.configureButton(title: UIButtonTitle.genderMale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioUnfill)
            self.bttnFemale.configureButton(title: UIButtonTitle.genderFemale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioFill)
        }
    }
    
    
}


extension RegisterViewController {
    private func setUIView() {
        self.lblHeaderTitle.configureLabel(text: UIName.signup, color: .appColor, fontStyle: .extraBold, fontSize: FontSize.boldTitle30.generateFontSize())
        
        self.lblFullname.configureLabel(text: UIName.fullName, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        self.nameTextField.placeholder = UIPlaceholder.enterFullname
        
        self.lblEmail.configureLabel(text: UIName.email, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        self.emailTextField.placeholder = UIPlaceholder.enterEmail
        
        
        self.lblPassword.configureLabel(text: UIName.password, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        self.passwordTextField.placeholder = UIPlaceholder.enterPassword
        
        self.lblGender.configureLabel(text: UIName.gender, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        
        self.lblPhone.configureLabel(text: UIName.mobileNumber, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        self.phoneTextField.placeholder = UIPlaceholder.enterPhone
        
        self.bttnSignup.configureButton(title: UIButtonTitle.signupText, fontStyle: .extraBold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .whiteColor , backgroundColor: .appColor)
        self.bttnSignup.setBorder(radius: self.bttnSignup.frame.size.height / 2 ,color: .whiteColor, width: 1.0)
        
        
        self.bttnMale.configureButton(title: UIButtonTitle.genderMale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioUnfill)
        self.bttnFemale.configureButton(title: UIButtonTitle.genderFemale, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor, imageName: ImageCollection.radioUnfill)
        
        
        
        self.bttnMale.setAttributedTitle(NSAttributedString(string: "Male"), for: .normal)
        self.bttnFemale.setAttributedTitle(NSAttributedString(string: "Female"), for: .normal)
        self.nameView.setBorder(radius: 10.0, color: .appColor, width: 1.5)
        self.emailView.setBorder(radius: 10.0, color: .appColor, width: 1.5)
        self.passwordView.setBorder(radius: 10.0, color: .appColor, width: 1.5)
        self.phoneView.setBorder(radius: 10.0, color: .appColor, width: 1.5)
        
        self.bttnMale.tag = 1
        self.bttnFemale.tag = 2
    }
}
