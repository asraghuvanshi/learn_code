//
//  ProfileViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ProfileViewController : UIViewController {
    //  MARK:  UIView IBOutlet Connection
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    
    // MARK: Private and Global Variable Declarations
    
    
    // MARK:  UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    //  MARK:  Setup Init View Layout
    func configureView() {
        DispatchQueue.main.async {
            [weak self] in
            self?.imgBack.image = UIImage(named: ImageCollection.backImage)
            self?.imgChat.image = UIImage(named: ImageCollection.chatIcon)
        }
        updateCurrentUser()
    }
    
    
    //   MARK:  Fetch current User From Firebase Database
    func updateCurrentUser() {
        guard let userId = FirebaseAuth.Auth.auth().currentUser?.uid else { return }

        DatabaseManager.shared.fetchCurrentUser(userId: userId, completion: { userData,error in
            DispatchQueue.main.async { [weak self] in
                self?.lblHeaderTitle.configureLabel(text: userData?.fullName ?? "", color: .appColor, fontStyle: .extraBold, fontSize: FontSize.navigationTitle18.generateFontSize())
            }
            print(error, userData?.fullName)
        })
    }
    
    
    //  MARK:  OnClicK Chat Button Action
    @IBAction func onClickChatAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //  MARK: OnClick Logout Action
    
    @IBAction func onClickLogoutAction(_ sender: Any) {
        let rootVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: IntroViewController.className) as! IntroViewController
        rootVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    
    //  MARK:  OnClick Chat Support Action
    @IBAction func onClickChatSupportAction(_ sender: Any) {
        
        let chatvc = AppStoryboard.Qticket.instance.instantiateViewController(withIdentifier: SupportViewController.className) as! SupportViewController
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatvc, animated: true)
    }
    
}

