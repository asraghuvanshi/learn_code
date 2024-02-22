//
//  AdminChatViewCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit

class AdminChatViewCell: UITableViewCell {
    
    //  MARK:  Admin ChatCell IBOutlet Connections
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var lblTxtMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //  MARK:  Configure Chat Data
    func configureChatData(message: String) {
        messageView.setBorder(radius: self.messageView.frame.size.height / 2, color: .blackColor , width: 1)
        lblTxtMessage.configureLabel(text: message, color: .whiteColor, fontStyle: .semibold, fontSize: FontSize.title14.generateFontSize())
    }
}
