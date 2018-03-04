//
//  UIViewController+Extension.swift
//  TestProject2
//
//  Created by vamsi krishna reddy kamjula on 3/4/18.
//  Copyright © 2018 vamsi krishna reddy kamjula. All rights reserved.
//

import UIKit

/**
 * Error Alerts based on the message passed
 */
extension UIViewController{
    
    func showAlert(message:String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Warning!", comment: "Warning title"), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK title"), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
