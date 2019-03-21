//
//  ViewControllerTests.swift
//  RatingBarTests
//
//  Created by Jason Kim on 3/20/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import XCTest
@testable import RatingBar

class ViewControllerTests: XCTestCase {

    class MockDelegatedToViewControllerDelegate {
        weak var delegate: ViewControllerDelegate?
    }
    
    func testViewController_Setup() {
        let viewController = ViewController()
        XCTAssertNotNil(viewController.ratingBarCVController.delegate)
    }
    
    func testRatingLevelLabel_Change() {
        let viewController = ViewController()
        let mock = MockDelegatedToViewControllerDelegate()
        mock.delegate = viewController
        
        mock.delegate?.updateRatingLevelLabel(newRatingLevel: 4)
        XCTAssertEqual(viewController.ratingLevelLabel.text, String(4))
    }

}
