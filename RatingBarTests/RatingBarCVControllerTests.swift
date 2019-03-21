//
//  RatingBarCVControllerTests.swift
//  RatingBarTests
//
//  Created by Jason Kim on 3/19/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import XCTest
@testable import RatingBar

class RatingBarCVControllerTests: XCTestCase {
    
    class MockConformingToViewControllerDelegate: ViewControllerDelegate {
        
        var mockNewRatingLevel: Int = 0
        
        func updateRatingLevelLabel(newRatingLevel: Int) {
            mockNewRatingLevel = newRatingLevel
        }
    }
    
    func testRatingBarCVController_Setup() {
        let ratingBarCVController = RatingBarCVController(collectionViewLayout: UICollectionViewFlowLayout())
        let layout = ratingBarCVController.collectionViewLayout as! UICollectionViewFlowLayout
        ratingBarCVController.viewDidLoad()
        XCTAssertNil(ratingBarCVController.delegate)
        XCTAssertEqual(layout.scrollDirection, .horizontal)
        XCTAssertFalse(ratingBarCVController.collectionView.showsHorizontalScrollIndicator)
        XCTAssertEqual(ratingBarCVController.cRatingBarCellId, "cRatingBarCellId")
        XCTAssertEqual(ratingBarCVController.numberOfRatingBarCells, 10)
        XCTAssertEqual(layout.minimumLineSpacing, 5)
        let numberOfCells: CGFloat = 10
        let cellSpacing: CGFloat = 5
        let width: CGFloat = (ratingBarCVController.collectionView.frame.width - (cellSpacing * (numberOfCells - 1))) / numberOfCells
        XCTAssertEqual(ratingBarCVController.collectionView(ratingBarCVController.collectionView, layout: ratingBarCVController.collectionView.collectionViewLayout, sizeForItemAt: IndexPath(row: 0, section: 0)), CGSize(width: width, height: 40))
    }
    
    func testViewControllerDelegate_NewRatingLevel() {
        let mock = MockConformingToViewControllerDelegate()
        let ratingBarCVController = RatingBarCVController(collectionViewLayout: UICollectionViewFlowLayout())
        ratingBarCVController.delegate = mock
        ratingBarCVController.viewDidLoad()
        XCTAssertEqual(mock.mockNewRatingLevel, 0)
        ratingBarCVController.delegate?.updateRatingLevelLabel(newRatingLevel: 5)
        XCTAssertEqual(mock.mockNewRatingLevel, 5)
        
    }
    
    func testNumberOfRatingCells_DefaultTen() {
        let ratingBarCVController = RatingBarCVController(ratingLevel: 5, collectionViewLayout: UICollectionViewFlowLayout())
        
        XCTAssertEqual(ratingBarCVController.collectionView(ratingBarCVController.collectionView, numberOfItemsInSection: ratingBarCVController.ratingLevel), 10)
    }

}
