//
//  ConversationViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 26/12/2023.
//

import UIKit



class ConversationViewController : UIViewController {
    
    
    //  MARK:  UIView IBOutlet Connections
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var conversationTableView: UITableView!
    
    @IBOutlet weak var senderOuterView: UIView!
    @IBOutlet weak var senderInnerView: UIView!
    @IBOutlet weak var messageSendBttn: UIButton!
    
    
    
    //  MARK:  Private and Public Variables
    
   
    
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
        self.registerChatTableCell() // Register Tableview Cell

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imgBack.image = UIImage(named: ImageCollection.backImage)
            self.messageSendBttn.setImage(UIImage(named: ImageCollection.chatIcon), for: .normal)
            self.lblTitle.configureLabel(text: UINavigationTile.chats, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.navigationTitle18.generateFontSize())
            
            self.senderOuterView.setBorder(radius: self.senderOuterView.frame.size.height / 2, color: .appColor, width: 0.8)
            
        }
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    //   MARK:  Assign UITableCell Delegate
    func registerChatTableCell() {
        self.conversationTableView.register(UINib(nibName: SenderUserCell.className, bundle: nil), forCellReuseIdentifier: SenderUserCell.className)
        
        self.conversationTableView.register(UINib(nibName: ReceiverUserCell.className, bundle: nil), forCellReuseIdentifier: ReceiverUserCell.className)
       
        self.conversationTableView.delegate = self
        self.conversationTableView.dataSource = self
       
        self.conversationTableView.estimatedRowHeight = 150.0
        self.conversationTableView.rowHeight = UITableView.automaticDimension
    }
    
   
    
    //  MARK:  OnClick Back Button Action
    @IBAction func onClickBackAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension ConversationViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = conversationTableView.dequeueReusableCell(withIdentifier: SenderUserCell.className, for: indexPath) as! SenderUserCell
            return cell
        } else {
            let cell = conversationTableView.dequeueReusableCell(withIdentifier: ReceiverUserCell.className, for: indexPath) as! ReceiverUserCell
            return cell
        }
 
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
}
