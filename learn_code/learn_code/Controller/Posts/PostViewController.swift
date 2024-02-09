//
//  PostViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 08/02/2024.
//

import UIKit
import IQKeyboardManager
import AVFoundation

class PostViewController : UIViewController {
    //  MARK:   UIView IBOutlet Connections
    
    @IBOutlet weak var bttnPost: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var postTextField: UITextView!
    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var mediaView: CardView!
    @IBOutlet weak var bttnMediaCancel: UIButton!
    @IBOutlet weak var mediaBottomVw: NSLayoutConstraint!
    
    //  MARK:  Variable Declarations
    var imagePicker = UIImagePickerController()
    var currentUserData: LoggedUserModel?
    var pickedImage = UIImage()
    var pickedVideo = Data()
    var isPhotoSelected = true

    
    //  MARK:   UIView Lifecycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitViewLayout()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //  MARK:  Configure Init View Layout
    func configureInitViewLayout() {
        DispatchQueue.main.async{
            self.navigationController?.isNavigationBarHidden = true
            self.imgMedia.isHidden = true
            self.bttnMediaCancel.isHidden = true
            
            self.lblTitle.configureLabelAndAlignment(text: UINavigationTitle.createPost.capitalized, color: .slateGrayColor, fontStyle: .bold, fontSize: FontSize.navigationTitle18.generateFontSize(), align: .center)
            
            self.bttnPost.configureButton(title: UIButtonTitle.post, fontStyle: .bold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    }
    
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //  MARK:   OnClick Post Media Actions
    @IBAction func onClickPostAction(_ sender: Any) {
        guard let userData = self.currentUserData else { return }
        MessageManager.shared.uploadPost(userId: userData.userId ?? "",
                                         userName: userData.fullName ?? "",
                                         userEmail: userData.userEmail ?? "",
                                         profile: userData.profileImageUrl ?? "",
                                         imageUrl: self.pickedImage,
                                         content: postTextField.text ?? "",
                                         completion: { error in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                print("this is error")
            }
        })
    }
    
    //  MARK:  OnClick Media Selection Action
    @IBAction func onClickMediaAction(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        showImagePicker(vc: self)
    }
    
    
    //  MARK:  OnClick Cancel Media Selection
    @IBAction func onClickMediaCancelAction(_ sender: Any) {
        self.imgMedia.isHidden = true
        self.bttnMediaCancel.isHidden = true
    }
}


//   MARK:  Handle Keyboard
extension PostViewController {
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if postTextField.isEditable {
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.mediaBottomVw, keyboardWillShow: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.mediaBottomVw, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        // Keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        }else {
            viewBottomConstraint.constant = 0
        }
        
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}



extension PostViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        
        if let image = info[.originalImage] as? UIImage{
            self.pickedImage = image
            self.imgMedia.image = image
            self.imgMedia.isHidden = false
            self.bttnMediaCancel.isHidden = false
            self.isPhotoSelected = true
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func showImagePicker(vc:UIViewController = UIViewController(),enableVideoPicker:Bool = false){
        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let openCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (data) in
            self.openCamera(vc: vc)
        }
        
        let openGalary = UIAlertAction(title: "Photo library", style: .default) { (data) in
            self.openGallery(vc: vc)
        }
        
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(openCamera)
        alert.addAction(openGalary)
        
        alert.addAction(cancelBtn)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(vc:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            vc.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have camera"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(vc:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            vc.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have gallery"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
