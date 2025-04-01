//
//  HearTestV2TUnitTesting.swift
//  HearTestV2TUnitTesting
//
//  Created by Christopher  Ladeira  on 2025/04/01.
//

import Testing

import Testing
import XCTest
@testable import HearTestV2


class MathTests: XCTestCase {
    
    func testGenerateShuffledString() {
        let vc = TestPageViewModel()
        let result = vc.setRoundAnswer()
        
        XCTAssertEqual(result.count, 3, "The result should be a string with exactly 3 characters.")
        
        for char in result {
            XCTAssertTrue(char >= "1" && char <= "9", "The string should only contain digits between 1 and 9.")
        }

        let uniqueChars = Set(result)
        XCTAssertEqual(uniqueChars.count, 3, "The result should not contain duplicate digits.")
    }
}

