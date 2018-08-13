//
//  InfiniteScrollingView.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/13.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import UIKit

class InfiniteScrollingView: UIActivityIndicatorView, ADKInfiniteScrollingViewProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adkInfiniteScrollingStopped(_ scrollView: UIScrollView!) {
        stopAnimating()
    }
    
    func adkInfiniteScrollingTriggered(_ scrollView: UIScrollView!) {
        stopAnimating()
    }
    
    func adkInfiniteScrollingLoading(_ scrollView: UIScrollView!) {
        startAnimating()
    }

}
