//
//  BinarySearchExtractTest.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/20/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//



import XCTest
@testable import BinarySearch

class BinarySearchExtractTests: XCTestCase {
  
  func testExtract() {
    func convertToDict(val:Int) -> Dictionary<String, Int> {
      return ["testValue": val]
    }
    let dictArray = (0...10).map(convertToDict)

    var result = dictArray.binarySearch(6, extract:{$0["testValue"]!})
    XCTAssertEqual(result, 6)
    result = dictArray.binarySearchFirst(6, extract:{$0["testValue"]!})
    XCTAssertEqual(result, 6)
    result = dictArray.binarySearchLast(6, extract:{$0["testValue"]!})
    XCTAssertEqual(result, 6)
    
    // with predicate >=
    result = dictArray.binarySearchLast(6, extract:{$0["testValue"]!}, predicate:{$0>=$1})
    XCTAssertEqual(result, 10)
    result = dictArray.binarySearchFirst(6, extract:{$0["testValue"]!}, predicate:{$0>=$1})
    XCTAssertEqual(result, 6)
    var rangeResult = dictArray.binarySearchRange(6, extract:{$0["testValue"]!}, predicate:{$0>=$1})
    XCTAssertEqual(rangeResult?.startIndex, 6)
    XCTAssertEqual(rangeResult?.endIndex, 10)
    
    // with predicate <=
    result = dictArray.binarySearchFirst(6, extract:{$0["testValue"]!}, predicate:{$0<=$1})
    XCTAssertEqual(result, 0)
    result = dictArray.binarySearchLast(6, extract:{$0["testValue"]!}, predicate:{$0<=$1})
    XCTAssertEqual(result, 6)
    rangeResult = dictArray.binarySearchRange(6, extract:{$0["testValue"]!}, predicate:{$0<=$1})
    XCTAssertEqual(rangeResult?.startIndex, 0)
    XCTAssertEqual(rangeResult?.endIndex, 6)
  
  }
}
