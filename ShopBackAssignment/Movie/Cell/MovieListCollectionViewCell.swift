//
//  MovieListCollectionViewCell.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/13.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import SDWebImage
import UIKit

let movieListCollectionViewCellIdentifier = "MovieListCollectionViewCell"

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var heartImageView: UIImageView!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var bottomSeparatorLayer: CALayer!
    
    var popularity: String? {
        didSet {
            popularityLabel.text = popularity
        }
    }
    
    var posterPath: String? {
        didSet {
            if let posterPath = posterPath, posterPath.count > 0 {
                posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300_and_h450_bestv2/\(posterPath)"), placeholderImage: UIImage.init(named: "Icon-Placeholder"))
            } else {
                posterImageView.image = UIImage.init(named: "Icon-Placeholder")
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomSeparatorLayer = CALayer.init()
        layer.addSublayer(bottomSeparatorLayer)
        
        heartImageView.image = UIImage.adkImage(UIImage.init(named: "Icon-Heart"), tintColor: UIColor.red)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        popularityLabel.text = ""
        posterImageView.image = nil
        titleLabel.text = ""
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bottomSeparatorLayer.frame = CGRect(x: 0.0, y: frame.size.height - 1.0, width: frame.size.width - 1.0, height: 1.0)
        bottomSeparatorLayer.backgroundColor = UIColor.adkColor(withARGBHexString: "999999").cgColor
    }
    
}
