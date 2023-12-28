//
//  HomeViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit


class HomeViewController : UIViewController {
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIView()
    }
    
    //  MARK:  OnClick Set Init View Layout
    func configureUIView() {
        
        self.navigationController?.isNavigationBarHidden = true
//        imgBack.image = UIImage(named: ImageCollection.backImage)
        imgChat.image = UIImage(named: ImageCollection.chatIcon)
        DatabaseManager.fetchUser()
    }
    
    
    //  MARK:  OnClick Chat Button Action
    @IBAction func onClickChatAction(_ sender: Any) {
        let tabVC =  AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ChatHistoryViewController.className) as! ChatHistoryViewController
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
}
