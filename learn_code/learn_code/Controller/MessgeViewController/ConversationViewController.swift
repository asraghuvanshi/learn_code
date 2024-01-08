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

    var isNewConversation: Bool = true
    
    var userEmail: String = ""
    var userData: UserResponse?
    var conversationData: ConversationModel?
    var receiverId: String = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
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
            self.messageSendBttn.setImage(UIImage(named: ImageCollection.chatIcon), for: .normal)
            self.lblUserName.configureLabel(text: self.userData?.fullName ?? "", color: .blackColor, fontStyle: .semibold, fontSize: FontSize.navigationTitle18.generateFontSize())
            
            self.senderOuterView.setBorder(radius: self.senderOuterView.frame.size.height / 2, color: .appColor, width: 0.8)
        }
        self.observeMessages()
        
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
    
    //  MARK: Observe Messages
    func observeMessages() {
        DispatchQueue.global().async {
            DatabaseManager.shared.fetchAllConversationData(completion: {[weak self] (conversations,error)  in
                self?.conversationData = conversations
                DispatchQueue.main.async {
                    self?.conversationTableView.reloadData()
                }
            })
        }
    }
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //  MARK:  OnClick Send Button Action
    @IBAction func onClickSendAction(_ sender: Any) {
      
        let ref = Database.database().reference().child("messages").childByAutoId()
        let currentUserId = FirebaseAuth.Auth.auth().currentUser?.uid
        
        let timeStamp:NSNumber = (Int(NSDate().timeIntervalSince1970) as? NSNumber)!
        let values = ["content": self.messageTextField.text,
                      "senderId": currentUserId,
                      "receiverId": self.receiverId,
                      "timeStamp": timeStamp
        ] as [String : Any]
        
        ref.updateChildValues(values, withCompletionBlock: { [weak self] error, databaseReponse in
            
        })
        
    }
    
}


//  MARK:  TableView Delegates and DataSource Methods
extension ConversationViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = conversationTableView.dequeueReusableCell(withIdentifier: SenderUserCell.className, for: indexPath) as! SenderUserCell
            if let senderData = self.conversationData {
                cell.configureSenderCell(message: senderData.content ?? "")
            }
            return cell
        } else {
            let cell = conversationTableView.dequeueReusableCell(withIdentifier: ReceiverUserCell.className, for: indexPath) as! ReceiverUserCell
            if let receiverData = self.conversationData {
                cell.configureReceiverCell(message: receiverData.content ?? "")
            }
            return cell
        }
 
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
}
