//
//  SupportViewController.swift.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/02/2024.
//

import UIKit

class SupportViewController : UIViewController {
    
    //  MARK:   UIView IBOutlet Connections
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblHelp: UILabel!
    
    @IBOutlet weak var btnChat: UIButton!
    
    @IBOutlet weak var btnCallus: UIButton!
    
    //  MARK:  View Lifecycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatInitView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //  MARK:   Set Init Chat Layout
    
    func setChatInitView() {
        DispatchQueue.main.async {[weak self] in
            guard let self  = self else {
                return
            }
            self.view.backgroundColor = .blackColor
            self.navigationController?.isNavigationBarHidden = true
            
            self.lblTitle.configureLabelAndAlignment(text: UIName.chatSupportText.capitalized, color: .whiteColor, fontStyle: .extraBold, fontSize: FontSize
                .boldTitle24.generateFontSize(), align: .center)
            
            self.lblHelp.configureLabelAndAlignment(text: UIName.help.capitalized, color: .whiteColor, fontStyle: .extraBold, fontSize: FontSize
                .boldTitle20.generateFontSize(), align: .center)
            
            self.btnChat.configureButton(title: UIButtonTitle.chatWithAgent, fontStyle: .bold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .systemYellow, backgroundColor: .blackColor)
            self.btnChat.setBorder(radius: 8, color: .whiteColor, width: 2)
            
            
            self.btnCallus.configureButton(title: UIButtonTitle.callUs, fontStyle: .bold, fontSize: FontSize.buttonFont18.generateFontSize(), color: .systemYellow ,backgroundColor: .blackColor)
            self.btnCallus.setBorder(radius: 8, color: .whiteColor, width: 2)
            
        }
    }
    
    //  MARK:   OnClick Chat Button Action
    @IBAction func onClickChatAction(_ sender: Any) {
        let customerChatVC = AppStoryboard.Qticket.instance.instantiateViewController(identifier: SupportChatViewController.className) as! SupportChatViewController
        self.navigationController?.pushViewController(customerChatVC, animated: true)
        
    }
    
    
    //   MARK:  OnClick   Call Button Action
    @IBAction func onClickCallAction(_ sender: Any) {
        let chatVC = AppStoryboard.Qticket.instance.instantiateViewController(withIdentifier: SupportViewController.className) as! SupportViewController
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
}
