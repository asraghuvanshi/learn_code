//
//  ActiveUserCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 21/12/2023.
//

import UIKit

class ActiveUserCell: UICollectionViewCell {

    //  MARK:  Collection Cell IBOutlet Connection
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    //  MARK:  Configure Active User Cell
    func configureActiveUserCell(activeuser: UserResponse) {
        
        if let profile = activeuser.profileImageURL, let activeUserProfile = URL(string: profile) {
            profileImage.sd_setImage(with: activeUserProfile)
        }
        
        profileImage.contentMode = .scaleToFill
        profileImage.setBorder(radius: self.profileImage.frame.size.height / 2, color: .appColor, width: 1.5)
        
        lblUserName.configureLabelAndAlignment(text: activeuser.fullName ?? "", color: .lightGray, fontStyle: .semibold, fontSize: FontSize.title13.generateFontSize(), align: .center)
    }
}
