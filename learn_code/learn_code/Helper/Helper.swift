//
//  Helper.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/12/2023.
//

import UIKit


extension UIViewController {
    
    /// An alert view
    func showAlert(title: String?, message: String?) -> UIAlertController {
       return showAlert(title: title, message: message) { () in }
    }
    
    func showAlertBackNavigation(title: String?, message: String?) -> UIAlertController {
       return showAlertWithBackNavigation(title: title, message: message) { () in }
    }
    
    func showAlertTextField(title: String?, message: String?, buttons: [String], uiBlock: @escaping (_ alert: UIAlertController, _ textField: UITextField) -> Void, completionAction:@escaping (_ title: String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for button in buttons {
                alert.addAction(UIAlertAction(title: button, style: .default, handler: { (action) in
                    completionAction(action.title ?? "")
                }))
            }
            
            alert.addTextField(configurationHandler: { (textField) in
                uiBlock(alert, textField)
            })
            self.present(alert, animated: true) { }
        }
    }
    
    func showAlert(title: String?, message: String?, completionAction:@escaping () -> Void)  -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completionAction()
            }))
            
            self.present(alert, animated: true) { }
        }
        return alert
    }
    
    func showAlertWithBackNavigation(title: String?, message: String?, completionAction:@escaping () -> Void)  -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.back()
                //completionAction()
                
            }))
            
            self.present(alert, animated: true) { }
        }
        return alert
    }
    
    func showAlert(title: String?, message: String?, buttons: [String], completionAction:@escaping (_ title: String) -> Void)  -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            for button in buttons {
                alert.addAction(UIAlertAction(title: button, style: .default, handler: { (action) in
                    completionAction(action.title ?? "")
                }))
            }
            self.present(alert, animated: true) { }
        }
        return alert
    }
    
    func presentWithFadeInTransition(_ controller: UIViewController, animated: Bool) {
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: animated, completion: nil)
    }
    
    func present(vc: UIViewController) {
        DispatchQueue.main.async {
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func push(vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func back() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

