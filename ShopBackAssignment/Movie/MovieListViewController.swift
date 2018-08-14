//
//  MovieListViewController.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/13.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import AppDevKit
import UIKit

class MovieListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    
    // FIXME: move to data store
    private var data: [Movie] = [Movie]()
    private var page = 1
    private var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Movies"
        setupCollectionView()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        setupInfiniteScrollingView()
        setupPullToRefreshView()
        fetchData(page: 1)
    }
    
    deinit {
        //collectionView.showInfiniteScrolling = false
    }

    // MARK: Private methods
    
    private func fetchData(page: Int) {
        // FIXME: move to data store
        MovieService.getMovies(sort: "release_date.desc", page: page) { [weak self] (movies) in
            if let results = movies?.results, let page = movies?.page, let total = movies?.totalPages, let strongSelf = self {
                if page == 1 && results.count > 0 {
                    strongSelf.data.removeAll()
                }
                strongSelf.data.append(contentsOf: results)
                strongSelf.page = page
                strongSelf.total = total
                strongSelf.collectionView.showInfiniteScrolling = total > page;
                strongSelf.collectionView.showPullToRefresh = true
                strongSelf.collectionView.reloadData()
                strongSelf.collectionView.infiniteScrollingContentView.stopAnimating()
                strongSelf.collectionView.pullToRefreshContentView.stopAnimating()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        
        setupCollectionViewCell()
    }
    
    private func setupCollectionViewCell() {
        collectionView.register(UINib(nibName: movieListCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: movieListCollectionViewCellIdentifier)
    }
    
    private func setupInfiniteScrollingView() {
        let activityIndicatorView = InfiniteScrollingView.init(frame: CGRect(x: 0.0, y: 0.0, width: collectionView.frame.width, height: 50.0))
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicatorView.hidesWhenStopped = false
        activityIndicatorView.startAnimating()
        collectionView.adkAddInfiniteScrolling(withHandle: activityIndicatorView) { [weak self] in
            if let strongSelf = self {
                if (strongSelf.collectionView.infiniteScrollingContentView.state != ADKInfiniteScrollingState.stopped) {
                    strongSelf.collectionView.showPullToRefresh = false
                }
                
                strongSelf.fetchData(page: strongSelf.page + 1)
            }
        }
    }
    
    private func setupPullToRefreshView() {
        let pullToRefreshView = PullToRefreshView.init(frame: CGRect(x: 0.0, y: 0.0, width: collectionView.frame.width, height: 50.0))
        collectionView.adkAddPullToRefresh(withHandle: pullToRefreshView) { [weak self] in
            if let strongSelf = self {
                strongSelf.fetchData(page: 1)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieListCollectionViewCellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let movie = data[indexPath.item]
        if let popularity = movie.popularity {
            cell.popularity = String(format: "%.2f", popularity)
        }
        cell.posterPath = movie.posterPath
        cell.title = movie.title
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = data[indexPath.item]
        let movieDetailViewController = MovieDetailViewController.init()
        movieDetailViewController.movie = movie
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ADKNibSizeCalculator.sharedInstance().size(forNibNamed: movieListCollectionViewCellIdentifier, with: ADKNibSizeStyle.fixedHeightScaling)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}
