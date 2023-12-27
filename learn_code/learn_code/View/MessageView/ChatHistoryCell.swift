//
//  ChatHistoryCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 21/12/2023.
//

import UIKit

class ChatHistoryCell: UITableViewCell {

    @IBOutlet weak var activeUserCollectionView: UICollectionView!
    var profileData = ["image1","image2","image3","image4","image5","image6"]
    var userName = ["Christlle Jolly", "Michelle", "Christal", "Shailly", "Mercy", "Rubina Fleam"]

    override func awakeFromNib() {
        super.awakeFromNib()
        configureChatCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configureChatCell() {
        registerActiceUserCollectionCell()
    }
    
    func registerActiceUserCollectionCell() {
        DispatchQueue.main.async { [weak self] in
            self?.activeUserCollectionView.register(UINib(nibName: ActiveUserCell.className, bundle: nil), forCellWithReuseIdentifier:ActiveUserCell.className)
            self?.activeUserCollectionView.delegate = self
            self?.activeUserCollectionView.dataSource = self
        }
    }
    
}


extension ChatHistoryCell : UICollectionViewDelegate {
    
}

extension ChatHistoryCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profileData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activeUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveUserCell.className, for: indexPath) as! ActiveUserCell
        activeUserCell.configureActiveUserCell(profile: self.profileData[indexPath.item], username: self.userName[indexPath.item])
        return activeUserCell
    }
}


extension ChatHistoryCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = activeUserCollectionView.frame.size.width / 3.5
        let cellHeight = 140.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
