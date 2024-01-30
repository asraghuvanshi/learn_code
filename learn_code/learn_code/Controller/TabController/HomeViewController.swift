//
//  HomeViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import NotificationCenter

class HomeViewController : UIViewController {
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIView()
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

    }
    
    //  MARK:  OnClick Set Init View Layout
    func configureUIView() {
        let loggedUserEmail = FirebaseAuth.Auth.auth().currentUser?.email as? String
        UserDefaults.standard.set(loggedUserEmail, forKey: "userEmail")
        self.navigationController?.isNavigationBarHidden = true
//        imgBack.image = UIImage(named: ImageCollection.backImage)
        imgChat.image = UIImage(named: ImageCollection.chatIcon)
        DatabaseManager.shared.fetchUsers(completion: {data , error in
            
        })
    }
    
    
    //  MARK:  OnClick Chat Button Action
    @IBAction func onClickChatAction(_ sender: Any) {
        let tabVC =  AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ChatListViewController.className) as! ChatListViewController
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
    
    func handleNotifData() {
        let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
        let notifData = pref?.object(forKey: "NOTIF_DATA") as? NSDictionary
        let aps = notifData?["aps"] as? NSDictionary
        let alert = aps?["alert"] as? NSDictionary
        let body = alert?["body"] as? String
        
        // Getting image from UNNotificationAttachment
        guard let imageData = pref?.object(forKey: "NOTIF_IMAGE") else { return }
        guard let data = imageData as? Data else { return }
    }
    
    @objc func becomeActive() {
        self.handleNotifData()
    }
}
