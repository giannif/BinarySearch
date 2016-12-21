//
//  PerformanceTests.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/22/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class PerformanceTests: XCTestCase {
  
  func testFindingClosestValue() {
    let test = (0...100000).map {$0}
    var numberOfSteps = 0
    func counter(_ val1:Int, val2:Int) -> Bool {
      numberOfSteps += 1
      return val1 == val2
    }
    guard let result = test.binarySearch(2500, predicate:counter) else {
      XCTFail("Didn't find value.")
      return
    }
    XCTAssertEqual(test[result], 2500)
    XCTAssertEqual(numberOfSteps, 13)
  }
  
  func testLogN() {
    let test = (0...200000).map {$0}
    var numberOfSteps = 0
    func counter(_ val1:Int, val2:Int) -> Bool {
      numberOfSteps += 1
      return val1 == val2
    }
    guard let result = test.binarySearch(2500, predicate:counter) else {
      XCTFail("Didn't find value.")
      return
    }
    XCTAssertEqual(test[result], 2500)
    XCTAssertEqual(numberOfSteps, 14) // Doubling the input increases the number of steps by 1.
  }
}
