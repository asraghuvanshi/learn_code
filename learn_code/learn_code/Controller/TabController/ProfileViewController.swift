//
//  ProfileViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit


class ProfileViewController : UIViewController {
    //  MARK:  UIView IBOutlet Connection
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var imgChat: UIImageView!
    
    
    // MARK:  UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        imgBack.image = UIImage(named: ImageCollection.backImage)
        imgChat.image = UIImage(named: ImageCollection.chatIcon)
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

