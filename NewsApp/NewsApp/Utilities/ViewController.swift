//
//  UIViewController.swift
//  NewsApp
//
//  Created by Chinnadurai, Balaji (Cognizant) on 5/3/2024.
//

import UIKit

extension UIViewController {
    static func navigateViewController(identifer : String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifer)
    }
}
