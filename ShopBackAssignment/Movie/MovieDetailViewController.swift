//
//  MovieDetailViewController.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/14.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var bookingButton: UIButton!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var languagesLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            updateViewWithMovie()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViewWithMovie()
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if let movie = movie, let movieId = movie.id {
            MovieService.getMovie(id: movieId) { [weak self] (movie) in
                if let strongSelf = self {
                    strongSelf.movie = movie
                }
            }
        }
    }
    
    // MARK: Private methods
    
    func updateViewWithMovie() {
        guard isViewLoaded else {
            return
        }
        
        if let backdropPath = movie?.backdropPath, backdropPath.count > 0 {
            backdropImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)"))
        }
        
        let genreNames = movie?.genres?.compactMap { $0.name }
        if let genreNames = genreNames, genreNames.count > 0 {
            genresLabel.text = "• " + genreNames.joined(separator: " | ")
            genresLabel.adkHide(false, withConstraints: ADKLayoutAttribute.top)

        } else {
            genresLabel.text = ""
            genresLabel.adkHide(true, withConstraints: ADKLayoutAttribute.top)
        }
        
        let languageNames = movie?.spokenLanguages?.compactMap { $0.name }
        if let languageNames = languageNames, languageNames.count > 0 {
            languagesLabel.text = "• " + languageNames.joined(separator: " | ")
            languagesLabel.adkHide(false, withConstraints: ADKLayoutAttribute.top)
        } else {
            languagesLabel.text = ""
            languagesLabel.adkHide(true, withConstraints: ADKLayoutAttribute.top)
        }
        
        overviewLabel.text = movie?.overview
        
        if let posterPath = movie?.posterPath, posterPath.count > 0 {
            posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)"), placeholderImage: UIImage.init(named: "Icon-Placeholder"))
        } else {
            posterImageView.image = UIImage.init(named: "Icon-Placeholder")
        }
        
        if let runtime = movie?.runtime {
            runtimeLabel.text = "• \(runtime)m"
            runtimeLabel.adkHide(false, withConstraints: ADKLayoutAttribute.top)
        } else {
            runtimeLabel.text = ""
            runtimeLabel.adkHide(true, withConstraints: ADKLayoutAttribute.top)
        }
        
        titleLabel.text = movie?.title
    }
    
    // MARK: UI events

    @IBAction func tapBookingButton(_ sender: Any) {
        
    }
    
}
