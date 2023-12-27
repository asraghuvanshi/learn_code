//
//  IntroViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 29/11/2023.
//

import UIKit
import Foundation
import MapKit

class IntroViewController: UIViewController {

    //  MARK:  IBOutlet Connection
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var bttnLogin: UIButton!
    @IBOutlet weak var bttnSignup: UIButton!
    
    //  MARK:  UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitUI()
    }

    
    //  MARK:  SetInit UI Layout
    func setInitUI() {
        lblHeaderTitle.configureLabel(text: UIName.welcomeText, color: .white, fontStyle: .extraBold, fontSize: FontSize.boldTitle30.generateFontSize())
        self.view.backgroundColor = .appColor

        self.bttnLogin.configureButton(title: UIButtonTitle.loginText.uppercased(), fontStyle: .extraBold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .whiteColor, backgroundColor: .appColor)
        self.bttnLogin.setBorder(radius: self.bttnLogin.frame.size.height / 2, color: .whiteColor, width: 1.5)

        self.bttnSignup.configureButton(title: UIButtonTitle.signupText.uppercased(), fontStyle: .extraBold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .whiteColor, backgroundColor: .appColor)
        self.bttnSignup.setBorder(radius: self.bttnLogin.frame.size.height / 2, color: .whiteColor, width: 1.5)

        
    }
    
    //  MARK: Button Actions
    
    @IBAction func onClickMoveLoginScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    @IBAction func onClickMoveSignupScreen(_ sender: Any) {
        let signupViewController = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: RegisterViewController.className) as! RegisterViewController
        self.navigationController?.pushViewController(signupViewController, animated: true)
    }
    
}

