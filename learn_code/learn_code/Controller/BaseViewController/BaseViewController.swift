//
//  BaseViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 04/02/2024.
//

import UIKit
import Reachability

class BaseViewController : UIViewController {
    
    //  MARK:   View Lifecycle Delegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}
