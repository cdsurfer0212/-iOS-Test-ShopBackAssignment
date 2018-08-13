//
//  MovieListViewController.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/13.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    
    // FIXME: move to data store
    private var data: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        fetchData(page: 1)
    }

    // MARK: Private methods
    
    func fetchData(page: Int) {
        // FIXME: move to data store
        MovieService.getMovies(sort: "release_date.desc", page: page) { [weak self] (movies) in
            if let results = movies?.results, let totalPages = movies?.totalPages, let strongSelf = self {
                if page == 1 && results.count > 0 {
                    strongSelf.data.removeAll()
                }
                strongSelf.data.append(contentsOf: results)
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
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
    
    func setupCollectionViewCell() {
        collectionView.register(UINib(nibName: movieListCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: movieListCollectionViewCellIdentifier)
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
        // FIXME
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ADKNibSizeCalculator.sharedInstance().size(forNibNamed: movieListCollectionViewCellIdentifier, with: ADKNibSizeStyle.fixedHeightScaling)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}
