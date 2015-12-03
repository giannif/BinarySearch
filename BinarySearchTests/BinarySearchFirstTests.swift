//
//  BinarySearchTests.swift
//  BinarySearchTests
//
//  Created by Gianni Ferullo on 11/16/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class BinarySearchFirstTests: XCTestCase {
  
  let test = (0...100000).map {$0}
  
  func testPredicateEqual() {
    for find in 0...1000 {
      let result = test.binarySearchFirst(find, predicate: {$0 == $1})
      XCTAssertNotNil(result)
      XCTAssertEqual(find, result)
    }
  }
  
  func testPredicateLess() {
    for find in 1...1000 {
      // Find any value less than "find"
      let result = test.binarySearchFirst(find, predicate: {$0 < $1})
      XCTAssertNotNil(result)
      XCTAssert(result < find)
    }
  }
  
  func testPredicateLessOrEqual() {
    for find in 0...1000 {
      // Find any value less or equal than "find"
      let result = test.binarySearchFirst(find, predicate: {$0 <= $1})
      XCTAssertNotNil(result)
      XCTAssert(result <= find)
    }
  }
  
  func testPredicateGreater() {
    for find in 0...999 {
      // Find any value greater than "find"
      let result = test.binarySearchFirst(find, predicate: {$0 > $1})
      XCTAssertNotNil(result)
      XCTAssert(result > find)
    }
  }
  
  func testFindingClosestValue() {
    // Find any value greater than "find"
    let test = [0,3,9,10,11,12,13,18]
    var result = test.binarySearchFirst(0, predicate: {$0 >= $1})
    XCTAssertEqual(test[result!], 0)
    
    result = test.binarySearchFirst(1, predicate: {$0 >= $1})
    XCTAssertEqual(test[result!], 3)
    result = test.binarySearchFirst(2, predicate: {$0 >= $1})
    XCTAssertEqual(test[result!], 3)
    result = test.binarySearchFirst(3, predicate: {$0 >= $1})
    XCTAssertEqual(test[result!], 3)
    for input in 4...9 {
      result = test.binarySearchFirst(input, predicate: {$0 >= $1})
      XCTAssertEqual(test[result!], 9)
    }
  }
  
  func testPredicateGreaterOrEqual() {
    for find in 0...1000 {
      // Find any value greater than "find"
      let result = test.binarySearchFirst(find, predicate: {$0 >= $1})
      XCTAssertNotNil(result)
      XCTAssert(result == find)
    }
  }
  
  func testPredicateGreaterOrEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchFirst(3.0, predicate:{$0 >= $1})
    XCTAssertNil(result)
  }
  
  func testPredicateLessOrEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchFirst(0.0, predicate:{$0 <= $1})
    XCTAssertNil(result)
  }
  
  func testPredicateEqualFailSafe() {
    let dictArray = [1.0,2.0,Double.NaN]
    let result = dictArray.binarySearchFirst(3.0)
    XCTAssertNil(result)
  }
  
  
  
}
