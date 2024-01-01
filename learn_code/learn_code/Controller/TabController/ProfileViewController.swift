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
    
    
    // MARK:  UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        DispatchQueue.main.async {
            [weak self] in
            self?.imgBack.image = UIImage(named: ImageCollection.backImage)
            self?.imgChat.image = UIImage(named: ImageCollection.chatIcon)
        }
        updateCurrentUser()
    }
    
    
    func updateCurrentUser() {
        guard let userId = FirebaseAuth.Auth.auth().currentUser?.uid else { return }

        DatabaseManager.shared.fetchCurrentUser(userId: userId, completion: {username,error in
            DispatchQueue.main.async { [weak self] in
                self?.lblHeaderTitle.configureLabel(text: username, color: .appColor, fontStyle: .extraBold, fontSize: FontSize.navigationTitle18.generateFontSize())
            }
        })
    }
    
    @IBAction func onClickChatAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //  MARK: OnClick Logout Action
    
    @IBAction func onClickLogoutAction(_ sender: Any) {
        let rootVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: IntroViewController.className) as! IntroViewController
        rootVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
}

