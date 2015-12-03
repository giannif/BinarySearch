//
//  BinarySearchLast.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/19/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class BinarySearchLastTests: XCTestCase {
  
  let test = (0...100000).map {$0}
  
  func testFindingClosestValue() {
    let test = [0,3,9,10,11,12,13,18]
    var result = test.binarySearchLast(0, predicate: {$0 >= $1})
    XCTAssertEqual(test[result!], 18)
    result = test.binarySearchLast(5, predicate: {$0 <= $1})
    XCTAssertEqual(test[result!], 3)
    result = test.binarySearchLast(18, predicate: {$0 <= $1})
    XCTAssertEqual(test[result!], 18)
    result = test.binarySearchLast(17, predicate: {$0 <= $1})
    XCTAssertEqual(test[result!], 13)
    for input in 4...9 {
      result = test.binarySearchLast(input, predicate: {$0 >= $1})
      XCTAssertEqual(test[result!], 18)
    }
    for input in 4...8 {
      result = test.binarySearchLast(input, predicate: {$0 <= $1})
      XCTAssertEqual(test[result!], 3)
    }
    for input in 9...13 {
      result = test.binarySearchLast(input, predicate: {$0 <= $1})
      XCTAssertEqual(test[result!], input)
    }
    for input in 13...17 {
      result = test.binarySearchLast(input, predicate: {$0 <= $1})
      XCTAssertEqual(test[result!], 13)
    }
    result = test.binarySearchLast(18, predicate: {$0 <= $1})
    XCTAssertEqual(test[result!], 18)

  }

  func testPredicateGreaterOrEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchLast(3.0, predicate:{$0 >= $1})
    XCTAssertNil(result)
  }
  
  func testPredicateLessOrEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchLast(0.0, predicate:{$0 <= $1})
    XCTAssertNil(result)
  }
  
  func testPredicateEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchLast(3.0)
    XCTAssertNil(result)
  }
}