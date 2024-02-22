//
//  QueryTableViewCell.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit


public enum QueryType: String {
    case creditTransaction = "Credit Card Transaction Issue"
    case bookingDiffculties = "Booking Difficulties"
    case refundEnquiry = "Refund Enquiry"
    case ticketCancellation = "Ticket Cancellations"
    case eventInformation = "Event Informations"
    case moreOption = "More..."
    case issueNotListed = "Issue Not Listed"
}

protocol QueryEventDelegate : AnyObject {
    func queryTappedGesture(index: Int, message: String)
}
class QueryTableViewCell: UITableViewCell {

    
    //   MARK:  IBOutlet Connections
    @IBOutlet weak var queryCollectionView: UICollectionView!

    
    //  MARK:  Variable Declarations
    private let queryTypeArray = ["Credit Card Transaction Issue", "Booking Difficulties", "Refund Enquiry", "Ticket Cancellations","Event Informations", "More...","Issue Not Listed"]
    weak var delegate: QueryEventDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerQueryCollectionCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    //   MARK:  Register CollectionView Cell
    func registerQueryCollectionCell() {
        queryCollectionView.backgroundColor = .blackColor
        queryCollectionView.register(UINib(nibName: CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.className)
        
        queryCollectionView.delegate = self
        queryCollectionView.dataSource = self
    }
}


//  MARK:  CollectionView Delegates & DataSource Method
extension QueryTableViewCell : UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queryTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = queryCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.className, for: indexPath) as! CollectionViewCell
        cell.setCellData(data: self.queryTypeArray[indexPath.item])
        return cell
    }
}


//   MARK:  Collection View Flow Layout Delegate Setup
extension QueryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: queryTypeArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)]).width + 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.queryTappedGesture(index: indexPath.item, message: queryTypeArray[indexPath.item])
    }
    
}

