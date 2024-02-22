//
//  SupportChatViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class SupportChatViewController : UIViewController {
    
    //  MARK:  UIView IBOutlet Connection
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var typeMessageVw: CardView!
    @IBOutlet weak var innerMessageView: UIView!
    @IBOutlet weak var typeQueryTxtField: UITextView!
    @IBOutlet weak var bttnSend: UIButton!
    
    //   MARK:  Variables Declarations
    private let messageData = ["Hii!, I'am your personal Assistence", "What can i help you with?"]
    private var transactionArry = ["Double Charges", "Payment Processing Errors", "Disputed Transactions"]
    
    var message: String = ""
    var queryType: String = ""
    var index: Int = 0
    
    var currentUserId: String = {
        guard let currentUser = FirebaseAuth.Auth.auth().currentUser?.uid as? String else { return "" }
        return currentUser
    }()
    
    //  MARK:  View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitUILayout()
        registerTableViewCell()
    }
    
    
    func setInitUILayout() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            typeMessageVw.setBorder(radius: self.typeMessageVw.frame.size.height / 2 , color: .creamColor, width: 2)
            
            innerMessageView.layer.cornerRadius = innerMessageView.frame.size.height / 2
            
            typeQueryTxtField.setBorder(radius: typeQueryTxtField.frame.size.height / 2, color: .clear, width: 0)
            
            typeQueryTxtField.delegate = self
            
        }
    }
    
    //  MARK:  Register TableViewCell Delegate & DataSource
    func registerTableViewCell() {
        self.chatTableView.register(UINib(nibName: IntroChatCell.className, bundle: nil), forCellReuseIdentifier: IntroChatCell.className)
        
        self.chatTableView.register(UINib(nibName: QueryTableViewCell.className, bundle: nil), forCellReuseIdentifier: QueryTableViewCell.className)
        
        self.chatTableView.register(UINib(nibName: SenderChatSupportCell.className, bundle: nil), forCellReuseIdentifier: SenderChatSupportCell.className)
        
        self.chatTableView.register(UINib(nibName: AdminChatViewCell.className, bundle: nil), forCellReuseIdentifier: AdminChatViewCell.className)
        
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
    }
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //  MARK:  OnClick Send Button Action
    @IBAction func onClickSendButtonAction(_ sender: Any) {
        var query = ""
        guard !self.typeQueryTxtField.text.isEmpty else {
            self.showAlert(title: "Type Something", message: "", completionAction: {
                self.typeQueryTxtField.resignFirstResponder()
            })
            return
        }
       
        
        if  !message.isEmpty && typeQueryTxtField.text.isEmpty {
            query = message
        } else if message.isEmpty && !typeQueryTxtField.text.isEmpty {
            query = self.typeQueryTxtField.text ?? ""
        }
        MessageManager.shared.sendMessagesToAdmin(message: MessageModel(messageID: "", senderId: currentUserId, receiverId: "Admin Bot", content: query, timestamp: Date().timeIntervalSince1970), completion: { response in
            print(response)
        })
    }
}


//  MARK:  UITableView Delegate & DataSource Method
extension SupportChatViewController : UITableViewDelegate & UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return messageData.count
        } else if section == 1{
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: IntroChatCell.className, for: indexPath) as! IntroChatCell
            cell.configureChatCell(message: self.messageData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: QueryTableViewCell.className, for: indexPath) as! QueryTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            return 420
        } else {
            return 0
        }
    }
}



//  MARK:   Query Event Delegate Method Implementation
extension SupportChatViewController : QueryEventDelegate{
    ///   get selected index
    func queryTappedGesture(index: Int, message: String) {
        switch index {
        case 0:
            self.message = message
        case 1:
            self.message = message
        case 2:
            self.message = message
        case 3:
            self.message = message
        case 4:
            self.message = message
        case 5:
            self.message = message

        default:
            print("Something else")
        }
    }
}


extension SupportChatViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }
}
