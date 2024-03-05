//
//  UIAlertController.swift
//  NewsApp
//
//  Created by Chinnadurai, Balaji (Cognizant) on 5/3/2024.
//

import UIKit

extension UIAlertController {
    
    // Showing Alert with Title and Message
    static func showAlertWith(title:String, message: String? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alertVC
    }
}
