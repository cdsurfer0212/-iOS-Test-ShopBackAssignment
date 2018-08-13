//
//  PullToRefreshView.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/14.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import UIKit

class PullToRefreshView: UIView, ADKPullToRefreshViewProtocol {
    
    private var activityIndicatorViewView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupComponents()
    }
    
    // MARK: ADKPullToRefreshViewProtocol
    
    func adkPull(toRefreshStopped scrollView: UIScrollView!) {
        activityIndicatorViewView.stopAnimating()
    }
    
    func adkPull(toRefreshTriggered scrollView: UIScrollView!) {
        activityIndicatorViewView.startAnimating()
    }
    
    func adkPull(toRefreshLoading scrollView: UIScrollView!) {
        // no-op
    }
    
    // MARK: Private methods
    
    private func setupComponents() {
        activityIndicatorViewView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicatorViewView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorViewView.stopAnimating()
        addSubview(activityIndicatorViewView)
        NSLayoutConstraint(item: activityIndicatorViewView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: activityIndicatorViewView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
}
