//
//  ReceiverUserCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 27/12/2023.
//

import UIKit

class ReceiverUserCell: UITableViewCell {

    //  MARK:  UITableView Cell IBOutlet Connections
    @IBOutlet weak var imgReceiverProfile: UIImageView!
    @IBOutlet weak var lblTextMessage: UILabel!
    @IBOutlet weak var lblTimeStamp: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.dateStyle = .short
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    //   MARK:  Configure Receiver Cell
    func configureReceiverCell(message: String) {
        
        self.imgReceiverProfile.image = UIImage(named: "image2")
        self.imgReceiverProfile.contentMode = .scaleAspectFill
        self.imgReceiverProfile.setBorder(radius: self.imgReceiverProfile.frame.size.height / 2, color: .appColor , width: 1.5)

        self.lblTextMessage.text = message
        self.lblTextMessage.numberOfLines = .zero
        self.lblTextMessage.lineBreakMode = .byWordWrapping
        self.lblTextMessage.textColor = .white
        
        self.lblTimeStamp.text = formatter.string(from: Date())
        
        self.messageView.backgroundColor = .appColor
        self.messageView.setBorder(radius: 10, color: .whiteColor , width: 1.5)

        
    }
}
