//
//  BinarySearchTests.swift
//  BinarySearchTests
//
//  Created by Gianni Ferullo on 11/16/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class BinarySearchTests: XCTestCase {
  
  let test = (0...1000).map {$0}
  
  func testPredicateEqual() {
    for find in 0...1000 {
      // Find any value less than "find" 0 to 49
      let result = test.binarySearch(find, predicate: {$0 == $1})
      XCTAssertNotNil(result)
      XCTAssertEqual(find, result)
    }
  }
  
  func testPredicateLess() {
    for find in 1...1000 {
      // Find any value less than "find"
      let result = test.binarySearch(find, predicate: {$0 < $1})
      XCTAssertNotNil(result)
      XCTAssert(result < find)
    }
  }
  
  func testPredicateLessOrEqual() {
    for find in 0...1000 {
      // Find any value less or equal than "find"
      let result = test.binarySearch(find, predicate: {$0 <= $1})
      XCTAssertNotNil(result)
      XCTAssert(result <= find)
    }
  }
  
  func testPredicateGreater() {
    for find in 0...999 {
      // Find any value greater than "find"
      let result = test.binarySearch(find, predicate: {$0 > $1})
      XCTAssertNotNil(result)
      XCTAssert(result > find)
    }
  }
  
  func testPredicateGreaterOrEqual() {
    for find in 0...1000 {
      // Find any value greater than "find"
      let result = test.binarySearch(find, predicate: {$0 >= $1})
      XCTAssertNotNil(result)
      XCTAssert(result >= find)
    }
  }

}
