//
//  NewsViewController.swift
//  dzWeather
//
//  Created by Янина on 29.11.21.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        let urlForNews = APIConstants.urlNews.rawValue
        
        guard let url = URL(string: urlForNews) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}

extension NewsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.isHidden = true
        print (print)
    }
}
