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

class HomeViewController : BaseViewController {
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIView()
    }
    
    //  MARK:  OnClick Set Init View Layout
    func configureUIView() {
        DispatchQueue.main.async {
            self.registerHomeTableCell()
            let loggedUserEmail = FirebaseAuth.Auth.auth().currentUser?.email as? String
            UserDefaults.standard.set(loggedUserEmail, forKey: "userEmail")
                self.navigationController?.isNavigationBarHidden = true
//                  imgBack.image = UIImage(named: ImageCollection.backImage)
                self.imgChat.image = UIImage(named: ImageCollection.chatIcon)
                
        }

        DatabaseManager.shared.fetchUsers(completion: {data , error in
            self.homeTableView.reloadData()
        
        })
    }
    
    //  MARK: Register TableView Cell
    func registerHomeTableCell() {
        self.homeTableView.register(UINib(nibName: HomeCell.className, bundle: nil), forCellReuseIdentifier: HomeCell.className)
        
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
    }
    
    
    //  MARK:  OnClick Chat Button Action
    @IBAction func onClickChatAction(_ sender: Any) {
        let tabVC =  AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ChatListViewController.className) as! ChatListViewController
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
}

//  MARK:  UITableViewDelegate and DataSource Methods
extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: HomeCell.className, for: indexPath) as! HomeCell
        
        cell.configureCellData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
