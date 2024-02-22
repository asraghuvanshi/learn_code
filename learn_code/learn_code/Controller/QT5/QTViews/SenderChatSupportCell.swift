//
//  SenderChatSupportCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit

class SenderChatSupportCell: UITableViewCell {

    @IBOutlet weak var messgaeView: UIView!
    @IBOutlet weak var lblTxtMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configureChatData(message: String) {
        self.lblTxtMessage.configureLabel(text: message, color: .whiteColor, fontStyle: .semibold, fontSize: FontSize.title16.generateFontSize())
    }
}
