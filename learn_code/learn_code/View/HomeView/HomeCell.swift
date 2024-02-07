//
//  HomeCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 04/02/2024.
//

import UIKit

class HomeCell: UITableViewCell {


    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var bttnFollow: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
        configureCellData()
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
    func configureCellData() {
        lblUsername.configureLabelAndAlignment(text: "Krishna Sharma", color: .blackColor, fontStyle: .semibold, fontSize: FontSize.title18.generateFontSize())
        
        lblDescription.configureLabelAndAlignment(text: "Software Engineer at 360-Bytes Mohali", color: .blackColor, fontStyle: .bold, fontSize: FontSize.title14.generateFontSize(),align: .natural)
    }
}
