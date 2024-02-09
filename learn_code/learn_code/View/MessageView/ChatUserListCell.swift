//
//  ChatUserListCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/12/2023.
//

import UIKit
import SDWebImage

class ChatUserListCell: UITableViewCell {
    
    //  MARK: TableViewCell IBOutlet Connections
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var profileVw: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblActiveTiming: UILabel!
    @IBOutlet weak var lblLastMessage: UILabel!
    @IBOutlet weak var imgActiveStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //  MARK:  Configure User List Data
    func configureUserList(userData: UserResponse) {
        if let urlString = userData.profileImageURL, let imageUrl = URL(string: urlString) {
            profileImage.sd_setImage(with: imageUrl)
        }
        
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.setBorder(radius: self.profileImage.frame.size.height / 2, color: .appColor, width: 1.5)
        
        
        self.lblUsername.configureLabel(text: userData.fullName ?? "", color: .blackColor, fontStyle: .bold, fontSize: FontSize.title16.generateFontSize())
    }
    
    
    //  MARK:  Configure User Last Sent Or Received Messages
    func displayLastConversations(message: MessageModel) {
        self.lblActiveTiming.configureLabel(text: convertTimestampToTime(timestamp: message.timestamp ?? 0.0), color: .appColor, fontStyle: .semibold, fontSize: FontSize.title12.generateFontSize())
        
        self.lblLastMessage.configureLabel(text: message.content ?? "", color: .lightGray, fontStyle: .regular, fontSize: FontSize.title12.generateFontSize())
        
        self.imgActiveStatus.configureLabel(text: "Seen", color: .lightGray, fontStyle: .semibold, fontSize: FontSize.title12.generateFontSize())
    }
}
