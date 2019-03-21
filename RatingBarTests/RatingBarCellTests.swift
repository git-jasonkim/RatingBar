//
//  RatingBarCellTests.swift
//  RatingBarTests
//
//  Created by Jason Kim on 3/20/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import XCTest
@testable import RatingBar

class RatingBarCellTests: XCTestCase {
    
    func testRatingBarCell_Setup() {
        let cell = RatingBarCell()
        
        XCTAssertEqual(cell.ratingView.backgroundColor!, UIColor.white)
    }
    
}
