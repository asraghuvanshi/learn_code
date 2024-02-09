//
//  FeedViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit
import IQKeyboardManager
import FirebaseCore
import FirebaseAuth


class FeedViewController : UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableVw: UITableView!
    
    var currentUserData: LoggedUserModel?
    var mediaModelData: [MediaPostModel]?
    var currentUserId : String {
        guard let userId = FirebaseAuth.Auth.auth().currentUser?.uid else {
            return ""
        }
        return userId
    }
    
    //  MARK:  UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewLayout()
    }
    
    
    //  MARK:  Configure View Layout
    func configureViewLayout() {
        
        DispatchQueue.main.async {
            self.registerUITableViewCell()
            
            self.lblTitle.configureLabelAndAlignment(text: UINavigationTitle.userFeeds.capitalized, color: .blackColor, fontStyle: .bold, fontSize: FontSize.navigationTitle18.generateFontSize(), align: .center)
        }
        
        ///  Fetch Current User Data
        DispatchQueue.global().async {
            DatabaseManager.shared.fetchCurrentUser(userId: self.currentUserId, completion: { currentUser, error in
                if error == nil {
                    self.currentUserData = currentUser
                    self.fetchMediaPost()
                } else {
                    print("Error while fetching User ")
                }
            })
        }
    }
    
    // MARK:  Fetch User Post
    func fetchMediaPost() {
        DatabaseManager.shared.fetchUserPosts(completion: { data, error  in
            self.mediaModelData = data
            self.tableVw.reloadData()
        })
    }
    
    //  MARK:  Register UITableView Cell
    func registerUITableViewCell() {
        tableVw.register(UINib(nibName: HomeCell.className, bundle: nil), forCellReuseIdentifier: HomeCell.className)
        
        tableVw.register(UINib(nibName: PostTableCell.className, bundle: nil), forCellReuseIdentifier: PostTableCell.className)
        
        tableVw.delegate = self
        tableVw.dataSource = self
    }
}


//   MARK:  UITableView Delegates & DataSource Methods
extension FeedViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.mediaModelData?.count ?? 0
        }
       
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableVw.dequeueReusableCell(withIdentifier: PostTableCell.className, for: indexPath) as? PostTableCell {
                if let unwrappedData = self.currentUserData {
                    cell.configurePostCell(user: unwrappedData)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 1 {
            if let cell = tableVw.dequeueReusableCell(withIdentifier: HomeCell.className, for: indexPath) as? HomeCell {
                if let unwrappedData = mediaModelData {
                    cell.configureMediaCell(mediaModel: unwrappedData[indexPath.row])
                }
                return cell
            } else {
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postViewController = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: PostViewController.className) as! PostViewController
        postViewController.hidesBottomBarWhenPushed = true
        postViewController.currentUserData = self.currentUserData
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
}

