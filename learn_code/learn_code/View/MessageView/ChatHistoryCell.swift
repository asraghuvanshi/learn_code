//
//  ChatHistoryCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 21/12/2023.
//

import UIKit

class ChatHistoryCell: UITableViewCell {

    @IBOutlet weak var activeUserCollectionView: UICollectionView!
    @IBOutlet weak var lblActiveTitle: UILabel! {
        didSet {
            lblActiveTitle.configureLabelAndAlignment(text: UIName.activeUser, color: .appColor, fontStyle: .bold, fontSize: FontSize.boldTitle20.generateFontSize(), align: .left)
        }
    }
    

    var activeUserData = [UserResponse]() {
        didSet {
            DispatchQueue.main.async {
                self.activeUserCollectionView.reloadData()
            }
           
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
 
    //  MARK:  Configure Cell Layout
    func configureCellLayout(){
        /// register  tableview cell
        registerActiveUserCollectionCell()
    }
    
    
    //  MARK:  Register TableView Cell
    func registerActiveUserCollectionCell() {
        self.activeUserCollectionView.register(UINib(nibName: ActiveUserCell.className, bundle: nil), forCellWithReuseIdentifier:ActiveUserCell.className)
        
        self.activeUserCollectionView.delegate = self
        self.activeUserCollectionView.dataSource = self
    }
    
}


extension ChatHistoryCell : UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activeUserData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activeUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveUserCell.className, for: indexPath) as! ActiveUserCell
        activeUserCell.configureActiveUserCell(activeuser: self.activeUserData[indexPath.item])
        return activeUserCell
    }
}


extension ChatHistoryCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 110.0
        let cellHeight = 160.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
