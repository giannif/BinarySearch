//
//  BinarySearchRangeTests.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/20/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class BinarySearchRangeTests: XCTestCase {
  
  func testFindingClosestValue() {
    var test = [0,3,9,10,11,12,13,18]
    for input in test {
      let result = test.binarySearchRange(input, predicate: {$0 >= $1})
      XCTAssertEqual(result?.startIndex, test.indexOf(input))
      XCTAssertEqual(result?.endIndex, test.count - 1)
    }
    for input in test {
      let result = test.binarySearchRange(input, predicate: {$0 <= $1})
      XCTAssertEqual(result?.startIndex, 0)
      XCTAssertEqual(result?.endIndex, test.indexOf(input))
    }
    let intermediateVals = [1,2,4,5,6,7,8,14,15,16,17]
    let expecteStart = [1,1,2,2,2,2,2,7,7,7,7]
    for (index, input) in intermediateVals.enumerate() {
      let result = test.binarySearchRange(input, predicate: {$0 >= $1})
      XCTAssertEqual(result?.startIndex, expecteStart[index])
      XCTAssertEqual(result?.endIndex, test.count - 1)
    }
    let expectedEnd = [0,0,1,1,1,1,1,6,6,6,6]
    for (index, input) in intermediateVals.enumerate() {
      let result = test.binarySearchRange(input, predicate: {$0 <= $1})
      XCTAssertEqual(result?.startIndex, 0)
      XCTAssertEqual(result?.endIndex, expectedEnd[index])
    }

    test = [0,3,9,10,11,12,13]
    for input in test {
      let result = test.binarySearchRange(input, predicate: {$0 >= $1})
      XCTAssertEqual(result?.startIndex, test.indexOf(input))
      XCTAssertEqual(result?.endIndex, test.count - 1)
    }
  }
}
