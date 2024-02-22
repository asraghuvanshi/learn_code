//
//  CollectionViewCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //  MARK:  Collection Cell IBOutLets
    @IBOutlet weak var lblQuery: UILabel!
    @IBOutlet weak var queryView: CardView!
    
    
    //  MARK:  Variable Declarations
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //  MARK:   Configure Cell Data
    func setCellData(data: String) {
        self.lblQuery.configureLabel(text: data, color: .yellow, fontStyle: .semibold, fontSize: FontSize.title16.generateFontSize())
        self.lblQuery.numberOfLines = 1
        self.queryView.backgroundColor = .blackColor
        self.queryView.setBorder(radius: self.queryView.frame.size.height / 2, color: .whiteColor, width: 1.5)
        
    }

}
