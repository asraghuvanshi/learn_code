//
//  SenderUserCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 27/12/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class SenderUserCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var imgSenderProfile: UIImageView!
    @IBOutlet weak var lblTextMessage: UILabel!
    @IBOutlet weak var lblTimeStamp: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //  MARK:  Configure Sender Cell
    func configureSenderCell(message: MessageModel) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profile_images")
    
        self.imgSenderProfile.contentMode = .scaleAspectFill
        self.imgSenderProfile.setBorder(radius: self.imgSenderProfile.frame.size.height / 2, color: .appColor , width: 1.5)
       
        self.lblTextMessage.configureLabelAndAlignment(text: message.textMessage, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title16.generateFontSize())

        self.lblTimeStamp.configureLabel(text: convertTimestampToTime(timestamp: message.timestamp), color: .appColor, fontStyle: .semibold, fontSize: FontSize.title12.generateFontSize())
        
        self.messageView.backgroundColor = .lightPurpleColor
        self.messageView.setBorder(radius: 15, color: .appColor , width: 0.5)

    }
    
}
