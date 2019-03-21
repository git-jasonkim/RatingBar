//
//  RatingBarCell.swift
//  RatingBar
//
//  Created by Jason Kim on 3/20/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import UIKit

class RatingBarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func adjustRatingViewBackground(ratingLevel: Int) {
        switch ratingLevel {
        case 1...3:
            ratingView.backgroundColor = UIColor.green
        case 4...6:
            ratingView.backgroundColor = UIColor.yellow
        case 7...9:
            ratingView.backgroundColor = UIColor.red
        case 10:
            ratingView.backgroundColor = UIColor.black
        default:
            break
        }
    }
    
    public func clearRatingViewBackground() {
        ratingView.backgroundColor = UIColor.white
    }
    
    lazy var ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private func setupCell() {
        addSubview(ratingView)
        ratingView.anchor(centerX: nil, centerY: centerYAnchor, top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 10)
    }
    
}
