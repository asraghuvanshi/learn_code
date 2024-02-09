//
//  PostTableCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 08/02/2024.
//

import UIKit

class PostTableCell: UITableViewCell {

    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTypingTitle: UILabel!
    @IBOutlet weak var horizontalLineVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    //  MARK:  Configure Cell Layout
    func configureCellLayout() {
       
        imgUserProfile.setBorder(radius: imgUserProfile.frame.size.height / 2 , color: .slateGrayColor , width: 1.5)
        
        lblTypingTitle.configureLabel(text: "Share your thoughts...", color: .platinumColor, fontStyle: .bold, fontSize: FontSize.title18.generateFontSize())
        
        horizontalLineVw.backgroundColor = .slateGrayColor
        horizontalLineVw.frame.size.width = 1.5
    }
    
    func configurePostCell(user: LoggedUserModel) {
        
        if let imageUrl = user.profileImageUrl , let image = URL(string: imageUrl) {
            self.imgUserProfile.sd_setImage(with: image)
        }
        
        lblUsername.configureLabel(text: user.fullName ?? "", color: .slateGrayColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
    }
}
