//
//  RatingBarCVController.swift
//  RatingBar
//
//  Created by Jason Kim on 3/19/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import UIKit

class RatingBarCVController: UICollectionViewController {
    
    public var ratingLevel: Int
    
    init(ratingLevel: Int = 1, collectionViewLayout: UICollectionViewFlowLayout) {
        self.ratingLevel = min(ratingLevel, 10)
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public weak var delegate: ViewControllerDelegate?
    internal let cRatingBarCellId = "cRatingBarCellId"
    internal let numberOfRatingBarCells = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupGesture()
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.collectionView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var location = gesture.location(in: self.view)
        location.x += self.collectionView.contentOffset.x
        location.y += self.collectionView.contentOffset.y
        guard let selectedIndexPath = self.collectionView.indexPathForItem(at: location) else { return }
        
        let ratingLevel = selectedIndexPath.item + 1
        self.ratingLevel = ratingLevel
        handleAdjustRatingLevel(ratingLevel: ratingLevel, section: selectedIndexPath.section)
        
    }
    
    private func setupController() {
        self.collectionView.backgroundColor = UIColor.white
        
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 5
        }
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(RatingBarCell.self, forCellWithReuseIdentifier: cRatingBarCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRatingBarCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ratingBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: cRatingBarCellId, for: indexPath) as! RatingBarCell
        if (indexPath.item + 1) <= self.ratingLevel {
            ratingBarCell.adjustRatingViewBackground(ratingLevel: self.ratingLevel)
        } else {
            ratingBarCell.clearRatingViewBackground()
        }
        return ratingBarCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ratingLevel = indexPath.item + 1
        self.ratingLevel = ratingLevel
        handleAdjustRatingLevel(ratingLevel: ratingLevel, section: indexPath.section)
    }
    
    private func handleAdjustRatingLevel(ratingLevel: Int, section: Int) {
        var i = 0
        while i <= (numberOfRatingBarCells - 1) { //number of items in section
            let ratingCellIndexPath = IndexPath(item: i, section: section)
            guard let ratingCell = collectionView.cellForItem(at: ratingCellIndexPath) as? RatingBarCell else {
                break }
            if i < ratingLevel {
                ratingCell.adjustRatingViewBackground(ratingLevel: ratingLevel)
            } else {
                ratingCell.clearRatingViewBackground()
            }
            i += 1
        }
        self.delegate?.updateRatingLevelLabel(newRatingLevel: ratingLevel)
    }
}

extension RatingBarCVController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(numberOfRatingBarCells)
        let cellSpacing: CGFloat = 5
        let width: CGFloat = (collectionView.frame.width - (cellSpacing * (numberOfCells - 1))) / numberOfCells
        return CGSize(width: width, height: 40)
    }
}
