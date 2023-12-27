//
//  SenderUserCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 27/12/2023.
//

import UIKit

class SenderUserCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var imgSenderProfile: UIImageView!
    @IBOutlet weak var lblTextMessage: UILabel!
    @IBOutlet weak var lblTimeStamp: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSenderCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //  MARK:  Configure Sender Cell
    func configureSenderCell() {
        self.imgSenderProfile.image = UIImage(named: "image1")
        self.imgSenderProfile.contentMode = .scaleAspectFill
        self.imgSenderProfile.setBorder(radius: self.imgSenderProfile.frame.size.height / 2, color: .appColor , width: 1.5)
        self.lblTextMessage.text = "Lorem Ipsum, lorem ipsum lorem ipsum lorem ipsum lorem ipsum"
        self.lblTextMessage.numberOfLines = .zero
        self.lblTextMessage.lineBreakMode = .byWordWrapping
        self.lblTextMessage.textColor = .whiteColor

        self.messageView.backgroundColor = .appColor
        self.messageView.setBorder(radius: 10, color: .whiteColor , width: 1.5)

    }
    
}
