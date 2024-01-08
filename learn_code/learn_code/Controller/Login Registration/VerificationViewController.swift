//
//  VerificationViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 16/12/2023.
//

import UIKit
import UserNotifications
import FirebaseMessaging

class VerificationViewController : UIViewController {
    
    // MARK:  UIView IBOutlet Connection
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    @IBOutlet weak var lblVerificationTitle: UILabel!
    
    
    // MARK:  Variable Declarations
    
    
    //  MARK: UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onClickLoginAction(_ sender: Any) {
        let dashBoardVC = AppStoryboard.Tab.instance.instantiateViewController(withIdentifier: MainTabController.className) as! MainTabController
        self.navigationController?.pushViewController(dashBoardVC, animated: true)
    }
    
    
}

extension VerificationViewController {
    func setInitUI() {
        lblHeaderTitle.configureLabel(text: UIName.otpVerification, color: .appColor, fontStyle: .semibold, fontSize: FontSize.boldTitle24.generateFontSize())
        lblHeaderTitle.textAlignment = .center
        
        self.lblVerificationTitle.configureLabel(text: UIName.otpSentMessage, color: .blackColor, fontStyle: .regular, fontSize: FontSize.title13.generateFontSize())
        self.lblVerificationTitle.textAlignment = .center
        self.lblVerificationTitle.numberOfLines = .zero
    }
}


