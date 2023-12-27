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
    func configureActiveUserCell(profile: String, username: String) {
        self.profileImage.image = UIImage(named: profile)
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.setBorder(radius: self.profileImage.frame.size.height / 2, color: .appColor, width: 2.5)
        
        self.lblUserName.configureLabelAndAlignment(text: username.capitalized, color: .lightGray, fontStyle: .semibold, fontSize: FontSize.title13.generateFontSize(), align: .center)
    }
}
