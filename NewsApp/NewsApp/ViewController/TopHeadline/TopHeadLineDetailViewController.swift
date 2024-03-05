//
//  TopHeadLineDetailViewController.swift
//  NewsApp

import UIKit
import WebKit

class TopHeadLineDetailViewController: UIViewController {

    @IBOutlet weak var customWebView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        guard let url = url else {return }
        let urlRequest = URLRequest(url: url)
        self.customWebView.load(urlRequest)
    }
}
