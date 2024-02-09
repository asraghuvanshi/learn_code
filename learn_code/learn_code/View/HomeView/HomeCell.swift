//
//  HomeCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 04/02/2024.
//

import UIKit
import SDWebImage


class HomeCell: UITableViewCell {


    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var bttnFollow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //   MARK:  Configure Cell View
    func configureCellView() {
        imgUserProfile.setBorder(radius: imgUserProfile.frame.size.height / 2, color: .lightLevendarBlue, width: 1.5)
        bttnFollow.configureButton(title: UIButtonTitle.follow, fontStyle: .semibold, fontSize: FontSize.buttonFont17.generateFontSize(), color: .appColor)
        
    }

    
    //  MARK:  Configure Cell Data
    func configureMediaCell(mediaModel: MediaPostModel) {
        lblUsername.configureLabelAndAlignment(text: mediaModel.fullName ?? "", color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        
        lblDescription.configureLabelAndAlignment(text: mediaModel.content ?? "", color: .blackColor, fontStyle: .regular, fontSize: FontSize.title14.generateFontSize(),align: .natural)
        
        if let userImageUrl = mediaModel.userImage, let url = URL(string: userImageUrl) {
            imgUserProfile.sd_setImage(with: url)
        }
        if let postUrl = mediaModel.postImage , let url = URL(string: postUrl) {
            imgPost.sd_setImage(with: url)
        }
    }
}
