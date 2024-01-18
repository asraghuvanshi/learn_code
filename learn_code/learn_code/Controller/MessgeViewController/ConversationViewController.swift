//
//  ConversationViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 26/12/2023.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth


class ConversationViewController : UIViewController {
    
    
    //  MARK:  UIView IBOutlet Connections
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var conversationTableView: UITableView!
    
    @IBOutlet weak var senderOuterView: UIView!
    @IBOutlet weak var senderInnerView: UIView!
    @IBOutlet weak var messageTextField: UITextView!
    
    @IBOutlet weak var messageSendBttn: UIButton!
    
    
    
    //  MARK:  Private and Public Variables
    private var messages = [Message]()
    private var chatMessages = [ChatMessage]()
    
    var isNewConversation: Bool = true
    
    var userEmail: String = ""
    var userData: UserResponse?
    var conversationData: [ChatMessageModel] = []
    var receiverId: String = ""
    var profileUrl: String = ""
    
    private var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    //  MARK:  UIView Lifecycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChatUI()
      
        
    }
    
    //  MARK:  View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //  MARK:  View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //   MARK: Configure Chat UI
    func configureChatUI() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // register tableview Cell
            
            self.registerChatTableCell()
            self.navigationController?.isNavigationBarHidden = true
            self.imgBack.image = UIImage(named: ImageCollection.backImage)
            if let profileUrl = self.userData?.profileImageURL , let profileImg = URL(string: profileUrl){
                self.imgProfile.sd_setImage(with: profileImg)
            }
            self.imgProfile.setBorder(radius: self.imgProfile.frame.size.height / 2, color: .lightLevendarBlue, width: 1.5)
            self.imgProfile.contentMode = .scaleAspectFill
            
            self.messageSendBttn.setImage(UIImage(named: ImageCollection.chatIcon), for: .normal)
            self.lblUserName.configureLabel(text: self.userData?.fullName ?? "", color: .blackColor, fontStyle: .semibold, fontSize: FontSize.navigationTitle18.generateFontSize())
            
            self.senderOuterView.setBorder(radius: self.senderOuterView.frame.size.height / 2, color: .appColor, width: 0.8)
        }
        
        MessageManager.shared.fetchConversations(completion: {_,_ in
            
        })
    }
    
    //   MARK:  Assign UITableCell Delegate
    func registerChatTableCell() {
        self.conversationTableView.register(UINib(nibName: SenderUserCell.className, bundle: nil), forCellReuseIdentifier: SenderUserCell.className)
        
        self.conversationTableView.register(UINib(nibName: ReceiverUserCell.className, bundle: nil), forCellReuseIdentifier: ReceiverUserCell.className)
        
        self.conversationTableView.delegate = self
        self.conversationTableView.dataSource = self
        
        self.conversationTableView.estimatedRowHeight = 350
        self.conversationTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //  MARK:  OnClick Send Button Action
    @IBAction func onClickSendAction(_ sender: Any) {
        let senderId = FirebaseAuth.Auth.auth().currentUser?.uid
        
        MessageManager.shared.sendMessage(message: ChatMessage(senderId: senderId ?? "", receiverId: receiverId, text: self.messageTextField.text ?? "" , timestamp: Date().timeIntervalSinceNow))
    }
    
}


//  MARK:  TableView Delegates and DataSource Methods
extension ConversationViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = (chatMessages[indexPath.row].senderId == "senderUserId") ? SenderUserCell.className : ReceiverUserCell.className
        let tableCell = (chatMessages[indexPath.row].senderId == "senderUserId") ? tableView.dequeueReusableCell(withIdentifier: SenderUserCell.className, for: indexPath) as! SenderUserCell :  tableView.dequeueReusableCell(withIdentifier: ReceiverUserCell.className, for: indexPath) as! ReceiverUserCell
        
        return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
