//
//  ChatListViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 19/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import CoreData

class ChatListViewController : BaseViewController {
    
    //  MARK:  UIView IBOutlet Connections
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var userListData:[UserResponse] = []
    var manager: UserManager = UserManager()
    
    var lastMessages: [SenderMessages] = []
    var counter = 0
    var currentUser: String {
        guard let userID = FirebaseAuth.Auth.auth().currentUser?.uid else { return ""
        }
        return userID
    }
    
    //  MARK:  UIView LifeCycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //  MARK:  Configure Init Layout View
    func configureInitView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.registerChatTableCell()
            self.lblTitle.configureLabel(text: UINavigationTile.chatHistory, color: .blackColor,fontStyle: .bold, fontSize: FontSize.navigationTitle18.generateFontSize())
            
            self.imgBack.image = UIImage(named: ImageCollection.backImage)
            self.imgChat.image = UIImage(named: ImageCollection.chatIcon)
            
        }
        self.fetchAllData()
    }
    
    
    //  MARK:   Register Table View delegate & dataSource
    func registerChatTableCell() {
        self.chatTableView.register(UINib(nibName: ChatHistoryCell.className, bundle: nil), forCellReuseIdentifier: ChatHistoryCell.className)
        self.chatTableView.register(UINib(nibName: ChatUserListCell.className, bundle: nil), forCellReuseIdentifier: ChatUserListCell.className)
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        self.chatTableView.estimatedRowHeight = 240
        self.chatTableView.rowHeight = UITableView.automaticDimension
        
        self.chatTableView.scrollIndicatorInsets = .zero
        
    }
    

    //   MARK:  Fetch User Last Message
    func fetchLastMessage(data: [UserResponse]){
        MessageManager.shared.fetchLastMessages{ [weak self] (lastMessages) in
            self?.lastMessages = []
            self?.userListData = data
            self?.lastMessages = lastMessages
            self?.appendUserData(data: self?.userListData ?? [])
            DispatchQueue.main.async {
                self?.chatTableView.reloadData()
            }
        }
    }
    
    // MARK:  Append Data in CoreData Model
    func appendUserData(data: [UserResponse]) {
        for data in data {
            ///  Checking if user data is already exists
            if PersistenceStorage.shared.userDataExistsInCoreData(data) {
                print("already exits")
            } else {
                /// No user exist data in core data
                self.manager.saveUserData(user: data)
            }
        }
    }
    
    
    //  MARK:  Checking Internet If data is not available then fetching data from core data model
    func fetchAllData() {
        if !isInternetReachable() {
            userListData = []
            self.manager.getAllUser().map{ data in
                if data.userId != currentUser {
                    userListData.append(UserResponse(userId: data.userId, fullName: data.fullName, userEmail: data.userEmail, userMobile: "", profileImageURL: "null"))
                }
            }
            self.chatTableView.reloadData()
        } else {
            DatabaseManager.shared.fetchUsers(completion: { userData , error in
                self.fetchLastMessage(data: userData)
            })
        }
    }
    
    
    //  MARK: Remove Keyboard Notification Oberserver
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}



//  MARK:  UITableView Delegate & DataSource Methods
extension ChatListViewController : UITableViewDelegate & UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.userListData.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let activeUserCell = tableView.dequeueReusableCell(withIdentifier: ChatHistoryCell.className, for: indexPath) as! ChatHistoryCell
                activeUserCell.activeUserData = self.userListData
                return activeUserCell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserListCell.className, for: indexPath) as! ChatUserListCell
                let user = self.userListData[indexPath.row]
                cell.configureUserList(userData: user)
                
                let senderReceiverID = [currentUser, user.userId ?? ""].sorted().joined(separator: "_")
                
                if let senderMessages = lastMessages.first(where: { $0.senderReceiverId == senderReceiverID }) {
                    if let lastMessage = senderMessages.messages.last {
                        cell.displayLastConversations(message: lastMessage)
                    }
                } else {
                    let temp = MessageModel(messageID: "", senderId: "", receiverId: "", content: "", timestamp: 0.0)
                    cell.displayLastConversations(message: temp)
                    
                }
                
                return cell
            }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        } else if indexPath.section == 1 {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let chatVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: ConversationViewController.className) as! ConversationViewController
            chatVC.hidesBottomBarWhenPushed = true
            chatVC.userData = self.userListData[indexPath.row]
            chatVC.receiverId = self.userListData[indexPath.row].userId ?? ""
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
}

