//
//  WKWebViewController.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/14.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import WebKit
import UIKit

class WKWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    private var progressView: UIProgressView!
    private var webView: WKWebView!
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let urlString = urlString {
            setupProgressView()
            let url = URL(string: urlString)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view = webView
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == #keyPath(WKWebView.estimatedProgress), object as? WKWebView === webView else {
            return
        }
        progressView.progress = Float(webView.estimatedProgress)
    }

    // MARK: - Private methods
    
    func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.isHidden = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        if #available(iOS 11, *) {
            NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0).isActive = true
        } else {
            var height = UIApplication.shared.statusBarFrame.size.height
            if let navigationController = navigationController {
                height = height + navigationController.navigationBar.frame.size.height
            }
            NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: height).isActive = true
        }
        
        NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 2.0).isActive = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
}
