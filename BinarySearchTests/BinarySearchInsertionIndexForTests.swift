//
//  BinarySearchInsertionIndexForTests.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 12/17/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import Foundation

//
//  BinarySearchInsertionIndexFoTests
//  BinarySearch
//
//  Created by Gianni Ferullo on 12/17/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import XCTest
@testable import BinarySearch

class BinarySearchInsertionIndexFoTests: XCTestCase {
  let testArray = [0,1,3,4]
  
  func testExists() {
    guard let result = testArray.binarySearchInsertionIndexFor(0) else {
      XCTAssert(true, "result is nil")
      return
    }
    XCTFail("result should be nil but it was \(result)")
  }
  
  func testFoundMiddleIndex() {
    guard let result = testArray.binarySearchInsertionIndexFor(2) else {
      XCTFail("result should be nil")
      return
    }
    XCTAssertEqual(result, 2, "Insertable at 2")
  }
  
  func testFoundBefore() {
    guard let result = testArray.binarySearchInsertionIndexFor(-1) else {
      XCTFail("result should be nil")
      return
    }
    XCTAssertEqual(result, 0, "Insertable at 0")
  }
  
  func testFoundAfter() {
    guard let result = testArray.binarySearchInsertionIndexFor(10) else {
      XCTFail("result should be nil")
      return
    }
    XCTAssertEqual(result, testArray.count, "Insertable at \(testArray.count)")
  }
  
  func testEmpty() {
    let testArray:[Int] = []
    guard let result = testArray.binarySearchInsertionIndexFor(10) else {
      XCTFail("result should be nil")
      return
    }
    XCTAssertEqual(result, 0, "Insertable at 0")
  }
  
  func testExtract() {
    struct Fruit {
      let name:String
    }
    // An Array of Fruits
    let dict = [
      Fruit(name:"apple"),
      Fruit(name:"banana"),
      Fruit(name:"orange")
    ]
    guard let result = dict.binarySearchInsertionIndexFor("cantaloupe", extract:{$0.name}) else {
      XCTFail("Failed to find a dictionary with a testValue of 'bananas'")
      return
    }
    XCTAssertEqual(result, 2, "Insertable at 2")
  }
  
}