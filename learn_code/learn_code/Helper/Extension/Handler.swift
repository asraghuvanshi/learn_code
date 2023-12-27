//
//  Handler.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit
import Foundation

class SharedInstance: NSObject {
    
    static let shared = SharedInstance()
    
    
    func moveToDashboard() {
        let tabVC =  AppStoryboard.Tab.instance.instantiateViewController(withIdentifier: MainTabController.className) as! MainTabController
        UIApplication.shared.windows.first?.rootViewController = tabVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
