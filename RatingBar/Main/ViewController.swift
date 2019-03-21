//
//  ViewController.swift
//  RatingBar
//
//  Created by Jason Kim on 3/20/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func updateRatingLevelLabel(newRatingLevel: Int)
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    lazy internal var ratingLevelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy internal var ratingBarCVController: RatingBarCVController = {
        let cv = RatingBarCVController(ratingLevel: 6, collectionViewLayout: UICollectionViewFlowLayout())
        self.ratingLevelLabel.text = String(cv.ratingLevel)
        cv.delegate = self
        return cv
    }()
    
    private func setupController() {
        view.backgroundColor = UIColor.white
        
        let ratingBarCV = ratingBarCVController.view!
        view.addSubview(ratingBarCV)
        ratingBarCV.anchor(centerX: nil, centerY: view.centerYAnchor, top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeading: 12, paddingBottom: 0, paddingTrailing: 12, width: 0, height: 40)
        
        view.addSubview(ratingLevelLabel)
        ratingLevelLabel.anchor(centerX: nil, centerY: nil, top: nil, leading: view.leadingAnchor, bottom: ratingBarCV.topAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeading: 12, paddingBottom: 25, paddingTrailing: 12, width: 0, height: 0)
    }
}

extension ViewController: ViewControllerDelegate {
    func updateRatingLevelLabel(newRatingLevel: Int) {
        ratingLevelLabel.text = String(newRatingLevel)
    }
}



