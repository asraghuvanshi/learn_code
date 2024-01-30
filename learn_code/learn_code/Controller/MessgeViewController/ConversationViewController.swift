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
import AVFoundation

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
    private var audioPlayer: AVAudioPlayer?

    var conversationData: [MessageModel] = []
    var userData: UserResponse?
    
    var isNewConversation: Bool = true
    var userEmail: String = ""
    var receiverId: String = ""
    var senderId: String = ""
    var profileUrl: String = ""
    var isUserTyping: Bool = false
    
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
            
            self.messageTextField.delegate = self
            
        }
     
        MessageManager.shared.observeConversations(receiverId: self.receiverId ,completion: { conversations in
            self.conversationData.removeAll()
            DispatchQueue.main.async {[weak self] in
                self?.getAllConversations()
            }
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
    
    func getAllConversations() {
        ///  Get all Conversations
        MessageManager.shared.getAllConversations(receiverId: self.receiverId ,completion: { conversations in
            self.conversationData.append(contentsOf: conversations)
            DispatchQueue.main.async {[weak self] in
                self?.conversationTableView.reloadData()
            }
        })
    }
    
    //  MARK:  Handle Send Messages
    func handleSendMessage() {
        guard let currentSenderId = FirebaseAuth.Auth.auth().currentUser?.uid else { return }
        MessageManager.shared.sendMessagesToUser(message: MessageModel(senderId: currentSenderId, receiverId: receiverId, content: self.messageTextField.text ?? "", timestamp: Date().timeIntervalSince1970), completion: { error in
            
            self.messageTextField.text = ""
            
            if error == nil {
                print("Message has been sent to the user")
            } else {
                print("Error while sending messages")
            }
        })
    }
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //  MARK:  OnClick Send Button Action
    @IBAction func onClickSendAction(_ sender: UIButton) {
        self.handleSendMessage()
    }
}


//  MARK:  TableView Delegates and DataSource Methods
extension ConversationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageData = self.conversationData[indexPath.row]

        guard let currentUserID = FirebaseAuth.Auth.auth().currentUser?.uid else {
            return UITableViewCell()
        }

        if currentUserID == messageData.senderId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderUserCell", for: indexPath) as! SenderUserCell
            cell.configureSenderCell(message: messageData)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverUserCell", for: indexPath) as! ReceiverUserCell
            cell.configureReceiverCell(message: messageData)
            return cell
        }
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ConversationViewController: AVAudioPlayerDelegate {
    func observeTyping() {
        guard let url = Bundle.main.url(forResource: "iphone_ding", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = audioPlayer else { return }
            
            audioPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


//   MARK:  TextView Delegate Methods
extension ConversationViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let userId = userData?.userId else { return }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let userId = userData?.userId else { return }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            handleSendMessage()
            return false
        }
        return true
    }
}
