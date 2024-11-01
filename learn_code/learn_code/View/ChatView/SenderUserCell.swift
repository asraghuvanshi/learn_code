//
//  SenderUserCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 27/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SenderUserCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var imgSenderProfile: UIImageView!
    @IBOutlet weak var lblTextMessage: UILabel!
    @IBOutlet weak var lblTimeStamp: UILabel!
    @IBOutlet weak var imgSelection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //  MARK:  Configure Sender Cell
    func configureSenderCell(message: MessageModel) {
        
        self.imgSelection.contentMode = .scaleAspectFill
        if let profileUrl = FirebaseAuth.Auth.auth().currentUser?.photoURL {
            imgSenderProfile.sd_setImage(with: profileUrl)
        }
    
        self.imgSenderProfile.contentMode = .scaleAspectFill
        self.imgSenderProfile.setBorder(radius: self.imgSenderProfile.frame.size.height / 2, color: .appColor , width: 1.5)
       
        self.lblTextMessage.configureLabelAndAlignment(text: message.content, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title16.generateFontSize())

        self.lblTimeStamp.configureLabel(text: convertTimestampToTime(timestamp: message.timestamp), color: .appColor, fontStyle: .semibold, fontSize: FontSize.title12.generateFontSize())
        
        self.messageView.backgroundColor = .lightPurpleColor
        self.messageView.setBorder(radius: 15, color: .appColor , width: 0.5)
    }
}
