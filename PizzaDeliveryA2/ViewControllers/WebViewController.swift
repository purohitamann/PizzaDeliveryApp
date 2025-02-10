//
//  WebViewController.swift
//  PizzaDeliveryA1
//
//  Created by Navya Vohra on 2025-02-10.
//


import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: containerView.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(webView)
        
    
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = containerView.center
        activityIndicator.hidesWhenStopped = true
        containerView.addSubview(activityIndicator)
        
       
        if let myURL = URL(string: "https://www.dominos.com") {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
    
    // MARK: - WKNavigationDelegate Methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
       
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       
        activityIndicator.stopAnimating()
        print("Failed to load web content with error: \(error.localizedDescription)")
    }
}

