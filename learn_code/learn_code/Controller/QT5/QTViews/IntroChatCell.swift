//
//  IntroChatCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 19/02/2024.
//

import UIKit

class IntroChatCell: UITableViewCell {

    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var lblTxtMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //  MARK:  Set Chat Data
    func configureChatCell(message: String) {
        contentView.backgroundColor = .blackColor
        
        messageView.setBorder(radius: 20, color: .whiteColor , width: 1)
        messageView.backgroundColor = .creamColor
        
        
        lblTxtMessage.configureLabelAndAlignment(text: message, color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title14.generateFontSize())
    }
}
