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
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var imgProfileIcon: UIImageView!
    
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
    
    
    //  MARK:  UIView LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIView()
    }
    
    //  MARK:  OnClick Profile Action
    @objc func onClickProfileAction() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    //  MARK:  OnClick Signup Button Action
    @IBAction func onClickSignupAction(_ sender: Any) {
        guard let userName = nameTextField.text ,let email = emailTextField.text , let password =  passwordTextField.text, let mobile = phoneTextField.text else { return }
        
        DatabaseManager.shared.addUser(userName: userName, userEmail: email, mobileNo: mobile, password: password, profileImg: imgProfileIcon.image!, completion: { error in
            print(error)
        })
        
        let loginVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: VerificationViewController.className) as! VerificationViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
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

//   MARK:  ImagePicker Controller Delegates
extension RegisterViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage =  info[.originalImage] as? UIImage {
            imgProfileIcon.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}


extension RegisterViewController {
    private func setUIView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.isNavigationBarHidden = true
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
            
            self.imgProfileIcon.setBorder(radius: self.imgProfileIcon.frame.size.height / 2 , color: .appColor, width: 1.5)
            self.imgProfileIcon.contentMode = .scaleAspectFit
            
            self.imgProfileIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickProfileAction)))
            self.imgProfileIcon.isUserInteractionEnabled = true
        }
    }
}
