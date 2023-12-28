//
//  LoginViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 02/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController : UIViewController {
    
    //  MARK:  UIView IBOutlet Connections
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var bttnLogin: UIButton!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var lblSignup: UILabel!
    @IBOutlet weak var bttnSignup: UIButton!
    
    //  MARK:  UIView Lifecycle Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
    }
    
    func setUIView() {
        
        self.lblHeaderTitle.configureLabel(text: UIName.login, color: .appColor, fontStyle: .extraBold, fontSize: FontSize.boldTitle30.generateFontSize())
        
        self.lblEmail.configureLabel(text: UIName.email, color: .black, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        
        self.lblPassword.configureLabel(text: UIName.password, color: .black, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        self.emailTxtField.placeholder = UIPlaceholder.enterEmail
        self.passwordTxtField.placeholder = UIPlaceholder.enterPassword
        
        self.emailView.setBorder(radius: 10.0, color: .appColor , width: 1.0)
        self.passwordView.setBorder(radius: 10.0, color: .appColor , width: 1.0)

        self.bttnLogin.configureButton(title: UIButtonTitle.loginText.uppercased(), fontStyle: .bold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .whiteColor, backgroundColor: .appColor)
        self.bttnLogin.setBorder(radius: self.bttnLogin.frame.size.height / 2 ,color: .whiteColor, width: 1.0)
        
        self.lblSignup.configureLabel(text: UIName.createAccount, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title16.generateFontSize())
       
        self.bttnSignup.configureButton(title: UIButtonTitle.signupText.uppercased(), fontStyle: .bold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .blackColor)

    }
    
    //  MARK:  Button Actions
    //  MARK:  OnClick Login Action
    @IBAction func onClickLoginAction(_ sender: Any) {
        
        if self.emailTxtField.text == "" {
            self.showAlert(title: "Login Error", message: "Please enter email address")
            return
        }
        else if passwordTxtField.text == "" {
            self.showAlert(title: "Login Error", message: "Enter your password address")
            return
        } else {
            DispatchQueue.main.async {
                FirebaseAuth.Auth.auth().signIn(withEmail: self.emailTxtField.text ?? "", password: self.passwordTxtField.text ?? "", completion: { (authResult , error) in
                    guard let authData = authResult , error == nil else {
                        self.showAlert(title: "Login Error", message: "Invalid credentials please enter valid data", buttons: ["OK"], completionAction: { _ in
                            
                        })
                        return
                    }
                    let result = authData.user
                    UserDefaults.standard.set(result.email, forKey: "userEmail")
                    SharedInstance.shared.moveToDashboard() // move to dashboard screen

                })
            }
        }
    }
    
    
    //  MARK:  OnClick Signup Button Action
    @IBAction func onClickSignupAction(_ sender: Any) {
        let signupVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: RegisterViewController.className) as! RegisterViewController

        DispatchQueue.main.async {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
}
